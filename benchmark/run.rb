#!env ruby
doc = <<DOCOPT

Run benchmarks for NxtBuilder project

Usage:
  benchmark/run [options]

Options:
  -h           Show this screen
  -p <path>    When provided will restrict the benchmarks to one subfolder
  -t <time>    Benchmark time (see gem benchmak/ips). Default 5
  -w <warmup>  Warm-up time (see gem benchmak/ips). Default 2
  -s           Save results to file. Default false

(path must be relative to `benchmark` folder)

DOCOPT

# In order to create new benchmarks create new ruby files inside benchmark
# folder. Each benchmark should define a class inside NxtBuilder::Benchmark
# module with a method :run. The code placed inside constructor will be runned
# before taking the measures.

module NxtBuilder
  module Benchmark
  end
end

if File.identical?(__FILE__, $0)
  # Script arguments
  scope = "."
  bench_time = 5
  warm_time = 2
  save = false

  if ARGV.index('-h')
    puts doc
    exit
  end

  i = 0
  bench_time = ARGV[i+1].to_i if i = ARGV.index('-t')
  warm_time = ARGV[i+1].to_i if i = ARGV.index('-w')
  scope = ARGV[i+1] if i = ARGV.index('-p')
  save = ARGV.index('-p')

  require 'erb'
  require 'bundler/setup'
  Bundler.require(:default, :benchmark)

  # Load Benchmarks
  bwd = File.expand_path('..', __FILE__) # benchmark work dir
  $LOAD_PATH << bwd
  require 'fixtures'

  puts File.expand_path("#{scope}/**/*.rb", bwd)

  Dir[File.expand_path("#{scope}/**/*.rb", bwd)].each do |file|
    require file
  end

  # Find benchmarks
  bench_classes = NxtBuilder::Benchmark.constants.map do |c|
    NxtBuilder::Benchmark.const_get(c)
  end.select do |c|
    c.kind_of?(Class) && c.method_defined?(:run)
  end

  # Calculate labels
  bench_labels = bench_classes.map do |c|
    c.to_s.split('::')[-1].gsub(/([A-Z])/, ' \1')
  end
  label_size = bench_labels.map(&:length).max + 4
  bench_labels.map! { |l| l.ljust(label_size) }

  # Initialize benchmarks
  benchs = {}
  bench_labels.each_with_index { |l,i| benchs[l] = bench_classes[i].new }
  results = {}

  # Take the measures
  require 'benchmark/ips'

  begin
    now = Time.now.to_s
    puts "Benchmark " << now << " time: #{bench_time} warmup: #{warm_time} "

    if save
      result_file = scope == '.' ? 'all' : scope
      $stdout = File.new(File.expand_path("results_#{result_file}.txt", bwd), 'w')
      puts "Benchmark " << now << " time: #{bench_time} warmup: #{warm_time} "
    end

    Benchmark.ips do |bm|
      bm.config(time: bench_time, warmup: warm_time)

      benchs.each do |label, bench|
        bm.report(label) do |n|
          i = 0
          result = nil
          while i < n
            i += 1
            result = bench.run
          end

          results[label] = result
        end
      end

      bm.compare!
    end

  ensure
    $stdout = STDOUT
  end

  if save
    result_file = scope == '.' ? 'all' : scope
    File.open(File.expand_path("results_#{result_file}.xml", bwd), 'w') do |f|
      f << %{<results start="#{now}" time="#{bench_time}" warmup="#{warm_time}">\n}
      f << "  <!--  " << now << " time: #{bench_time} warmup: #{warm_time}  -->"
      results.each do |label, result|
        f << "\n\n\n\n  <!--  " << label << "  -->\n\n  " << result.split("\n").join("\n  ")
      end
      f << "\n</results>"
    end
  end
end