require 'static_template/htmless_standard'

module NxtBuilder
  module Benchmark
    class StaticTemplateHtmlessFormatted < StaticTemplateHtmlessStandard

      def initialize
        @pool = Htmless::Pool.new(Htmless::Formatted)
      end

    end
  end
end