require 'nxt_builder/xml'
require 'nokogiri'

module NxtBuilder
  # Public: SimpleXML Builder
  #
  # This class is suitable for building simplier XML documents, for example when
  # no aditional namespace organization is used.
  class SimpleXML < XML
    ELEMENT_ = Nokogiri::XML::Element
    TEXT_ = Nokogiri::XML::Text

    def _tag(name, content_or_options = nil, options = {})
      # Normalize arguments
      if content_or_options.kind_of?(Hash)
        options = content_or_options
        content = nil
      else
        content = content_or_options
      end

      content = TEXT_.new(content, @doc) if content.kind_of?(String)

      node = ELEMENT_.new(name.to_s, @doc)
      options.each { |k, v| node[k.to_s] = v.to_s }
      node << content unless content.nil? || content.empty?

      if block_given?
        old_parent = @parent
        @parent = node
        begin
          yield
        ensure
          @parent = old_parent
        end
      end

      node
    end
  end
end
