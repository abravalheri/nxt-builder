# NxtBuilder

Builder-like library for generating HTML, using object-oriented approach and XML tree representation. This library is inspired by Erector, HTMLess, Arbre and Nokogiri::XML::Builder

*nxt-builder* (/nekst ˈbildər/) stands for **N**okogiri-based **X**ML **T**ree **Builder**

**Spoiler alert**: experimental stuff - this project has just started!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nxt_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nxt_builder

## Usage

TODO: Write usage instructions here

## Motivation

Sometimes writing Rails Helpers is really frustrating... You have to write so many `content_tag`s, everything is difficult :disappointed: and... well, let's not talk about the resulting :shit: HTML indentation.

Out there, there are few libraries that seem to solve this problem in an elegant way: [Erector](https://github.com/erector/erector), [HTMLess](https://github.com/pitr-ch/htmless), [Arbre](https://github.com/activeadmin/arbre) and [Nokogiri::XML::Builder](http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Builder).

Both Arbre and HTMLess have a nice DSL and are super fancy, but I am concerned because their DSLs apparently seem to call `#instance_exec` or something similar and this smells like an anti-pattern...

Erector on the other hand, is graceful, but I was wondering: *what if* it was empowered by a XML engine like Nokogiri?

By the way, Nokogiri has its own builder, but uses `#method_misssing` and all sorts of black magic that slow down any server...

This project aims to provide a proof of concept, building something similar to Erector but powered by Nokogiri internal XML representation. I plan to benchmark it together with those solutions listed above.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/abravalheri/nxt_builder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
