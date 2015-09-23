require 'nokogiri'
require 'nxt_builder/exceptions'

module NxtBuilder
  class HTML
    module ClassMethods
      attr_accessor :tag_cache

      def register(tag)
        super

        # Create a tag_cache so the XML elements can be cloned
        # instead of instantiated
        doc = Nokogiri::XML::Document.new
        @tag_cache ||= {}

        Array(tag).each do |t|
          name = t.to_s.freeze
          @tag_cache[name] = doc.create_element(name)
        end
      end

      def inherited(subclass)
        # Ensure inheritance
        subclass.tag_cache = (@tag_cache || {}).dup
      end
    end
  end
end
