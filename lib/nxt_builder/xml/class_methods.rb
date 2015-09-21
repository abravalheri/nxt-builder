require 'nokogiri'
require 'nxt_builder/exceptions'

module NxtBuilder
  class XML
    module ClassMethods
      def register(tag)
        tag_list = Array(tag)

        tag_methods = tag_list.map do |t|
          raise AlreadyDefinedMethod, t if method_defined?(t)

          method_name = t.to_s.gsub('-', '_')

          <<-EOS.gsub(/^\s{8}/, '').strip
            def #{method_name}(*args)
              args.unshift("#{method_name}")
              if block_given?
                tag!(*args, &Proc.new)
              else
                tag!(*args)
              end
            end
          EOS
        end.join("\n\n")

        class_eval(tag_methods, __FILE__, __LINE__ - 11)
      end

      def document_class
        Nokogiri::XML::Document
      end
    end
  end
end
