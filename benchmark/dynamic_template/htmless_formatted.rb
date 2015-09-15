require 'dynamic_template/htmless_standard'

module NxtBuilder
  module Benchmark
    class DynamicTemplateHtmlessFormatted < DynamicTemplateHtmlessStandard

      def initialize
        @catalog = FIXTURES[:catalog]
        @pool = Htmless::Pool.new(Htmless::Formatted)
      end

    end
  end
end