require 'nxt_builder/xml'
require 'nxt_builder/html/tags'
require 'nxt_builder/html/boolean_attributes'

module NxtBuilder
  class HTML < XML
    TAG_PREFIXES = [:data, :aria]

    register TAGS

    def doctype!(external_id = nil, system_id = nil, options = {})
      super('html', external_id, system_id)
    end

    def html!(*args)
      doctype!
      args.unshift(:html)
      if block_given?
        tag!(*args, &Proc.new)
      else
        tag!(*args)
      end
    end

    # def _tag(name, content_or_options = nil, options = {})
    #   if content_or_options.kind_of?(Hash)
    #     opt = content_or_options
    #   else
    #     opt = options
    #   end
    #
    #   # "Flatten" 1-dept prefixed hash attrs
    #   TAG_PREFIXES.each do |prefix|
    #     if opt[prefix]
    #       prefixed = opt.delete(prefix) || {}
    #       prefixed.inject(opt) do |acc,v|
    #         acc["#{prefix}-#{v[0].to_s.gsub('_', '-')}"] = v[1]; acc
    #       end
    #     end
    #   end
    #
    #   # Canonicalize boolean attributes
    #   opt.each do |k,v|
    #     if BOOLEAN_ATTRIBUTES.include?(k.to_s)
    #       v ? (opt[k] = k.to_s) : opt.delete(k)
    #     end
    #   end
    #
    #   super
    # end
  end
end
