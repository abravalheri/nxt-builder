module NxtBuilder
  module Benchmark
    class StaticTemplateErb

      def template
        # Taken from http://www.xmlfiles.com/examples/cd_catalog.xml
        <<-EOS.gsub(/^\s{8}/, '')
          <html>
            <body>
              <ul class="catalog">
                <li class="cd">
                  <p class="title">Empire Burlesque</p>
                  <p class="artist">Bob Dylan</p>
                  <p class="country">USA</p>
                  <p class="company">Columbia</p>
                  <p class="price">10.90</p>
                  <p class="year">1985</p>
                </li>
                <li class="cd">
                  <p class="title">Hide your heart</p>
                  <p class="artist">Bonnie Tylor</p>
                  <p class="country">UK</p>
                  <p class="company">CBS Records</p>
                  <p class="price">9.90</p>
                  <p class="year">1988</p>
                </li>
                <li class="cd">
                  <p class="title">Greatest Hits</p>
                  <p class="artist">Dolly Parton</p>
                  <p class="country">USA</p>
                  <p class="company">RCA</p>
                  <p class="price">9.90</p>
                  <p class="year">1982</p>
                </li>
              </ul>
            </body>
          </html>
        EOS
      end

      def initialize
        @builder = ERB.new(template)
      end

      def run
        @builder.result
      end
    end
  end
end