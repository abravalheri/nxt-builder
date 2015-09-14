require 'nokogiri'
require 'nxt_builder/exceptions'

module NxtBuilder
  class XML
    module ClassMethods
      def register(tag)
        tag_list = Array(tag)

        tag_list.each do |t|
          raise AlreadyDefinedMethod, t if method_defined?(t)

          method_name = t.to_s.gsub('-', '_')
          define_method(method_name) do |*args, &block|
            tag!(t, *args, &block) # unfortunatelly it can be implicity
          end
        end
      end

      def document_class
        Nokogiri::XML::Document
      end
    end
  end
end
