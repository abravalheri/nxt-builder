module NxtBuilder
  module Benchmark
    class DynamicTemplateErectorClass

      class Builder < Erector::Widget

        def content
          html do
            body do
              ul class: "catalog" do
                @catalog.cd.each do |cd|
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

        end

      end

      def initialize
        @catalog = FIXTURES[:catalog]
      end

      def run
        Builder.new(catalog: @catalog).to_html(prettyprint: true)
      end
    end
  end
end