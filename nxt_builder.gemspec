# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nxt_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "nxt_builder"
  spec.version       = NxtBuilder::VERSION
  spec.authors       = ["Anderson Bravalheri"]
  spec.email         = ["andersonbravalheri@gmail.com"]

  spec.summary       = "Builder-like library for generating HTML"
  spec.description   = <<-EOS
    Builder-like library for generating HTML, using object-oriented approach and XML tree representation. This library is inspired by Erector, HTMLess, Arbre and Nokogiri::XML::Builder
  EOS
  spec.homepage      = "http://github.com/abravalheri/nxt-builder"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"

  spec.add_runtime_dependency 'nokogiri', '~> 1.6.6'
end
