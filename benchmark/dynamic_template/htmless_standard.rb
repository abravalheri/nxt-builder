module NxtBuilder
  module Benchmark
    class DynamicTemplateHtmlessStandard

      def initialize
        @catalog = FIXTURES[:catalog]
        @pool = Htmless::Pool.new(Htmless::Standard)
      end

      def run
        # Taken from http://www.xmlfiles.com/examples/cd_catalog.xml
        @pool.get.go_in(@catalog) do |catalog|
          html do
            body do
              ul class: "catalog" do
                catalog.cd.each do |cd|
                  li class: "cd" do
                    p(class: "title") { text cd.title }
                    p(class: "artist") { text cd.artist }
                    p(class: "country") { text cd.country }
                    p(class: "company") { text cd.company }
                    p(class: "price") { text cd.price }
                    p(class: "year") { text cd.year }
                  end
                end
              end
            end
          end

        end.to_html!
      end

    end
  end
end