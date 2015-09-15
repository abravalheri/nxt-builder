module NxtBuilder
  module Benchmark
    class StaticTemplateErectorClass

      class Builder < Erector::Widget

        def content
          html do
            body do
              ul class: "catalog" do
                li class: "cd" do
                  p(class: "title") { text "Empire Burlesque" }
                  p(class: "artist") { text "Bob Dylan" }
                  p(class: "country") { text "USA" }
                  p(class: "company") { text "Columbia" }
                  p(class: "price") { text 10.90 }
                  p(class: "year") { text 1985 }
                end
                li class: "cd" do
                  p(class: "title") { text "Hide your heart" }
                  p(class: "artist") { text "Bonnie Tylor" }
                  p(class: "country") { text "UK" }
                  p(class: "company") { text "CBS Records" }
                  p(class: "price") { text 9.90 }
                  p(class: "year") { text 1988 }
                end
                li class: "cd" do
                  p(class: "title") { text "Greatest Hits" }
                  p(class: "artist") { text "Dolly Parton" }
                  p(class: "country") { text "USA" }
                  p(class: "company") { text "RCA" }
                  p(class: "price") { text 9.90 }
                  p(class: "year") { text 1982 }
                end
              end
            end
          end
        end

      end

      def run
        Builder.new.to_html(prettyprint: true)
      end
    end
  end
end