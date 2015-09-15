require 'nxt_builder/xml'
require 'nxt_builder/html/tags'

module NxtBuilder
  class HTML < XML
    register(TAGS)

    def doctype!(external_id = nil, system_id = nil)
      super('html', external_id, system_id)
    end

    def html!(*args, &block)
      doctype!
      tag!(:html, *args, &block)
    end

    alias_method :to_s, :to_html
  end
end