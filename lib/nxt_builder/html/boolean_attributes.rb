require 'set'
require 'nxt_builder/xml'

module NxtBuilder
  class HTML < XML
    BOOLEAN_ATTRIBUTES = [
      'disabled',
      'readonly',
      'multiple',
      'checked',
      'autobuffer',
      'autoplay',
      'controls',
      'loop',
      'selected',
      'hidden',
      'scoped',
      'async',
      'defer',
      'reversed',
      'ismap',
      'seamless',
      'muted',
      'required',
      'autofocus',
      'novalidate',
      'formnovalidate',
      'open',
      'pubdate',
      'itemscope',
      'allowfullscreen',
      'default',
      'inert',
      'sortable',
      'truespeed',
      'typemustmatch',
    ].to_set
  end
end
