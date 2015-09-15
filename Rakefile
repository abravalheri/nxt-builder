require 'bundler/gem_tasks'
require 'nokogiri'
require 'net/http'

HTML_TAGS_DIR = 'lib/nxt_builder/html'

task :tags do
  # scrap w3c site
  w3c_ref = Net::HTTP.get('www.w3.org', '/TR/html-markup/elements.html')
  doc = Nokogiri::HTML.parse(w3c_ref)
  tags = doc.css('.toc .element').map { |e| e.content.to_sym }.uniq.flatten

  mkdir_p(HTML_TAGS_DIR)
  file_name = File.expand_path('tags.rb', HTML_TAGS_DIR)
  File.open(file_name, 'w') do |f|
    f << "module NxtBuilder\n"
    f << "  class HTML < XML\n"
    f << "    TAGS = [\n"
    tags.each { |t| f << "      :#{t},\n" }
    f << "    ]\n"
    f << "  end\n"
    f << "end\n"
  end
end