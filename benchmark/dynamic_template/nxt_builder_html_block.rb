module NxtBuilder
  module Benchmark
    class DynamicTemplateNxtBuilderHtmlBlock

      def initialize
        @catalog = FIXTURES[:catalog]
        @builder = NxtBuilder::HTML.new
      end

      def run
        # Taken from http://www.xmlfiles.com/examples/cd_catalog.xml
        @builder.render! do |r|
          r.html do
            r.body do
              r.ul class: "catalog" do
                @catalog.cd.each do |cd|
                  r.li class: "cd" do
                    r.p(class: "title") { r.text! cd.title }
                    r.p(class: "artist") { r.text! cd.artist }
                    r.p(class: "country") { r.text! cd.country }
                    r.p(class: "company") { r.text! cd.company }
                    r.p(class: "price") { r.text! cd.price }
                    r.p(class: "year") { r.text! cd.year }
                  end
                end
              end
            end
          end

        end.to_s

      end

    end
  end
end