require "nxt_builder/xml/class_methods"

module NxtBuilder
  # Public: XML Builde.r
  class XML < Object
    # Design Guidelines:
    #
    # - Avoid to use names for methods that can conflict with tags. Methods that
    #   do not cause side effects may me named with an strating `_`, and methods
    #   that have side effects (like changing the buffer or the internal state)
    #   may end with `!`. It is ugly, but works...
    #
    # - Use document fragments as much as possible... Use the document just
    #  to create nodes. This enable an abscent root node.
    #
    # - Require user explicitly use doctypes and the xml opening instruction.

    extend ClassMethods

    # Public: Initialize the builder object.
    #
    # options - Hash options for builder:
    #          :encoding - String with character encoding (default: "UTF-8").
    def initialize(options = {})
      options = { encoding: 'UTF-8' }.merge(options)
      @encoding = options[:encoding]
      @doc = self.class.document_class.new
      @doc.encoding = @encoding
      @buffer = @doc.fragment
      @dtd = nil
      @opening_pi = nil
    end

    # Public: Creates a xml element but not append it to the buffer.
    #
    # tag - Name of the element to be created.
    # content - String content to be inserted inside tag
    #     (when `content` is omitted, function consider `options` the 2nd arg).
    # options - Hash with xml attributes for tag, e.g. :class, :id.
    # block - An optional block to be executed within a new empty buffer.
    #     After the block execution the buffer is inserted into the element
    #     content. Nested elements can be produced using methods that modify
    #     the buffer.
    #
    # Yields no argument.
    #
    # Examples:
    #
    #    builder = NxtBuilder::XML.new
    #
    #    builder._tag(:p, "I am a paragraph").to_s # => <p>I am a paragragh</p>
    #    builder.to_s # => ""
    #
    #    builder _tag(:p) { _tag(:span) }.to_s # => <p/>
    #    builder _tag(:p) { tag!(:span) }.to_s # => <p><span/></p>
    #    builder.to_s # => ""
    #
    # Returns the internal Node representation.
    def _tag(tag, *args)
      node = @doc.create_element(tag.to_s, *args)

      if block_given?
        old_buffer = @buffer
        @buffer = @doc.fragment
        begin
          yield
          node << @buffer
        ensure
          @buffer = old_buffer
        end
      end

      node
    end

    # Public: Similar to `_tag` but the generated element will be inserted
    # in the buffer. See #_tag.
    def tag!(tag, *args, &block)
      node = _tag(tag, *args, &block)
      @buffer << node

      node
    end

    # Public: Creates a text node and append it to the buffer.
    #
    # string - text to be appended to the buffer. Will be escaped.
    #
    # Returns the text node.
    def text!(string)
      node = @doc.create_text_node(string)
      @buffer << node

      node
    end

    # Public: Parses text representing xml into a node tree.
    #
    # string - text containing xml code
    #
    # Returns a nodeset corresponding to the string
    def _parse(string)
      fragment = (@doc.fragment << string)
      return fragment if fragment.children.length > 1

      fragment.child
    end

    # Public: Insert the argument string inside buffer, without scaping it.
    # Valid XML markup can be turned into child elements.
    #
    # string - Text representing the new child nodes
    #
    # Returns the resulting of parsing the string
    def raw!(string)
      node = _parse(string)
      @buffer << node

      node
    end

    def _cdata(string)
      @doc.create_cdata(string.to_s)
    end

    def cdata!(string)
      node = @doc.create_cdata(string.to_s)
      @buffer << node

      node
    end

    def _comment(string)
      @doc.create_comment(string.to_s)
    end

    def comment!(string)
      node = @doc.create_comment(string.to_s)
      @buffer << node

      node
    end

    def doctype!(name, external_id = nil, system_id = nil, options = {})
      options = { external: true }.merge(options)
      if options[:external]
        node = @doc.create_external_subset(name.to_s, external_id, system_id)
        node.external_subset.remove
      else
        node = @doc.create_internal_subset(name.to_s, external_id, system_id)
        node.internal_subset.remove
      end

      @dtd = node

      node
    end

    def xml!(options = {})
      # Explicitly requires the XML opening PI

      # normalize options
      options = {
        version: "1.0",
        encoding: @encoding,
        standalone: nil
      }.merge(options)

      version = options[:version]
      encoding = options[:encoding]
      standalone = options[:standalone]

      standalone = "yes" if standalone === true
      standalone = "no" if standalone === false

      content = %{version="#{version}"}
      content << %{encoding="#{encoding}"} if encoding
      content << %{standalone="#{standalone}"} if standalone

      node = Nokogiri::XML::ProcessingInstruction.new(@doc, 'xml', content)
      @opening_pi = node

      node
    end

    def pi!(name, content)
      # Create a process instruction <?#{name} #{content}?>
      node = Nokogiri::XML::ProcessingInstruction.new(@doc, name, content)
      @buffer << node

      node
    end

    def <<(element)
      element = @doc.create_text_node(element) if element.kind_of? String

      @buffer << element

      self
    end
    alias_method :append!, :<<
    alias_method :after!, :<<

    def prepend!(element)
      @buffer.prepend_child(element)

      self
    end
    alias_method :before!, :prepend!

    def clear_buffer!
      @buffer.content = ''

      self
    end

    def render!
      yield(self) if block_given?

      self
    end

    [:xml, :xhtml, :html].each do |format|
      define_method(:"to_#{format}") do |options = {}|
        to_format(format, options)
      end
    end

    alias_method :to_s, :to_xml

    def to_format(format, options = {})
      options = {
        encoding: @encoding,
        save_with: 0
      }.merge(options)

      options[:save_with] |= case format
        when :xml then Nokogiri::XML::Node::SaveOptions::AS_XML
        when :xhtml then Nokogiri::XML::Node::SaveOptions::AS_XHTML
        when :html then Nokogiri::XML::Node::SaveOptions::AS_XML
          # HTML identation issue :(
        else raise NotImplementedError, "Format #{format} not implemented"
      end
      options[:save_with] |= Nokogiri::XML::Node::SaveOptions::FORMAT
      options[:save_with] |= Nokogiri::XML::Node::SaveOptions::NO_DECLARATION

      response = ""
      response << @opening_pi.to_xml << "\n" if @opening_pi
      response << @dtd.to_xml << "\n" if @dtd
      response << @buffer.to_xml(options)
    end
  end
end
