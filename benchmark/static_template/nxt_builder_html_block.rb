module NxtBuilder
  module Benchmark
    class StaticTemplateNxtBuilderHtmlBlock

      def initialize
        @builder = NxtBuilder::HTML.new
      end

      def run
        # Taken from http://www.xmlfiles.com/examples/cd_catalog.xml
        @builder.render! do |r|
          r.html do
            r.body do
              r.ul class: "catalog" do
                r.li class: "cd" do
                  r.p(class: "title") { r.text! "Empire Burlesque" }
                  r.p(class: "artist") { r.text! "Bob Dylan" }
                  r.p(class: "country") { r.text! "USA" }
                  r.p(class: "company") { r.text! "Columbia" }
                  r.p(class: "price") { r.text! 10.90 }
                  r.p(class: "year") { r.text! 1985 }
                end
                r.li class: "cd" do
                  r.p(class: "title") { r.text! "Hide your heart" }
                  r.p(class: "artist") { r.text! "Bonnie Tylor" }
                  r.p(class: "country") { r.text! "UK" }
                  r.p(class: "company") { r.text! "CBS Records" }
                  r.p(class: "price") { r.text! 9.90 }
                  r.p(class: "year") { r.text! 1988 }
                end
                r.li class: "cd" do
                  r.p(class: "title") { r.text! "Greatest Hits" }
                  r.p(class: "artist") { r.text! "Dolly Parton" }
                  r.p(class: "country") { r.text! "USA" }
                  r.p(class: "company") { r.text! "RCA" }
                  r.p(class: "price") { r.text! 9.90 }
                  r.p(class: "year") { r.text! 1982 }
                end
              end
            end
          end
        end.to_s

      end

    end
  end
end