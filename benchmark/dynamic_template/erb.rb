module NxtBuilder
  module Benchmark
    class DynamicTemplateErb

      def template
        # Taken from http://www.xmlfiles.com/examples/cd_catalog.xml
        <<-EOS.gsub(/^\s{8}/, '')
          <html>
            <body>
              <ul class="catalog">
                <% @catalog.cd.each do |cd| %>
                  <li class="cd">
                    <p class="title"><%= cd.title %></p>
                    <p class="artist"><%= cd.artist %></p>
                    <p class="country"><%= cd.country %></p>
                    <p class="company"><%= cd.company %></p>
                    <p class="price"><%= cd.price %></p>
                    <p class="year"><%= cd.year %></p>
                  </li>
                <% end %>
              </ul>
            </body>
          </html>
        EOS
      end

      def initialize
        @builder = ERB.new(template)
        @catalog = FIXTURES[:catalog]
        @binding = binding()
      end

      def run
        @builder.result(@binding)
      end
    end
  end
end