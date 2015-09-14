require "nxt_builder/xml/class_methods"

module NxtBuilder
  class XML < Object
    # Avoid to use short names for methods to prevent conflicts between
    # tags and methods. Prefer using names finished in !

    extend ClassMethods

    def initialize
      @doc = self.class.document_class.new
      @buffer = @doc.fragment
    end

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

    def tag!(tag, *args, &block)
      node = _tag(tag, *args, &block)
      @buffer << node

      node
    end

    def text!(string)
      node = @doc.create_text_node(string)
      @buffer << node

      node
    end

    def _parse(string)
      fragment = (@doc.fragment << string)
      return fragment if fragment.children.length > 1

      fragment.child
    end

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

    def doctype!(name, external_id = nil, system_id = nil)
      @doc.create_external_subset(name.to_s, external_id, system_id)
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

    def to_s(options = {})
      options = {encoding: 'UTF-8'}.merge(options)
      @buffer.to_xml(options)
    end
  end
end
