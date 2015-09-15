module NxtBuilder
  module Benchmark
    class StaticTemplateArbre

      def run
        # Taken from http://www.xmlfiles.com/examples/cd_catalog.xml
        Arbre::Context.new do
          html do
            body do
              ul class: "catalog" do
                li class: "cd" do
                  para(class: "title") { text_node "Empire Burlesque" }
                  para(class: "artist") { text_node "Bob Dylan" }
                  para(class: "country") { text_node "USA" }
                  para(class: "company") { text_node "Columbia" }
                  para(class: "price") { text_node 10.90 }
                  para(class: "year") { text_node 1985 }
                end
                li class: "cd" do
                  para(class: "title") { text_node "Hide your heart" }
                  para(class: "artist") { text_node "Bonnie Tylor" }
                  para(class: "country") { text_node "UK" }
                  para(class: "company") { text_node "CBS Records" }
                  para(class: "price") { text_node 9.90 }
                  para(class: "year") { text_node 1988 }
                end
                li class: "cd" do
                  para(class: "title") { text_node "Greatest Hits" }
                  para(class: "artist") { text_node "Dolly Parton" }
                  para(class: "country") { text_node "USA" }
                  para(class: "company") { text_node "RCA" }
                  para(class: "price") { text_node 9.90 }
                  para(class: "year") { text_node 1982 }
                end
              end
            end
          end
        end.to_s

      end

    end
  end
end