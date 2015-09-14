$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nxt_builder'

require 'rspec/expectations'

RSpec::Matchers.define :have_method do |expected|
  match do |actual|
    actual.method_defined?(expected)
  end
end

RSpec::Matchers.define :have_instance_var do |expected|
  match do |actual|
    actual.instance_variable_defined?(expected)
  end
end

RSpec::Matchers.define :be_xml do
  match do |actual|
    begin
      bad_doc = Nokogiri::XML(actual) { |config| config.strict }
    rescue Nokogiri::XML::SyntaxError => e
      return false
    end

    true
  end
end
