module NxtBuilder
  module Benchmark
    class DynamicTemplateArbre

      def initialize
        @catalog = FIXTURES[:catalog]
      end

      def run
        # Taken from http://www.xmlfiles.com/examples/cd_catalog.xml
        Arbre::Context.new(catalog: @catalog) do
          html do
            body do
              ul class: "catalog" do
                catalog.cd.each do |cd|
                  li class: "cd" do
                    para(class: "title") { text_node cd.title }
                    para(class: "artist") { text_node cd.artist }
                    para(class: "country") { text_node cd.country }
                    para(class: "company") { text_node cd.company }
                    para(class: "price") { text_node cd.price }
                    para(class: "year") { text_node cd.year }
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