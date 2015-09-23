# NxtBuilder

Builder-like library for generating HTML, using object-oriented approach and XML tree representation. This library is inspired by Erector, HTMLess, Arbre and Nokogiri::XML::Builder

*nxt-builder* (/nekst ˈbildər/) stands for **N**okogiri-based **X**ML **T**ree **Builder**

## TL;DR

Despite of nice premises, implementation and syntax, NxtBuilder does not
provide significant gains in terms of performance when compared with
Nokogiri Builders (apparently `method_missing` is not so bad...).

Please consider using Nokogiri Builders with a cache strategy.

## Original Motivation

Sometimes writing Rails Helpers is really frustrating... You have to write
so many `content_tag`s, everything is difficult :disappointed: and... well,
let's not talk about the resulting :shit: HTML indentation.

Out there, there are few libraries that seem to solve this problem in an elegant way:
[Erector](https://github.com/erector/erector),
[HTMLess](https://github.com/pitr-ch/htmless),
[Arbre](https://github.com/activeadmin/arbre) and
[Nokogiri::XML::Builder](http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Builder).

Both Arbre and HTMLess have a nice DSL and are super fancy, but I am concerned
because their DSLs apparently seem to call `#instance_exec` or something
similar and this smells like an anti-pattern...

Erector on the other hand, is graceful, but I was wondering: *what if* it
was empowered by a XML engine like Nokogiri?

By the way, Nokogiri has its own builder, but uses `#method_missing`...

This project aims to provide a proof of concept, building something similar to
Erector but powered by Nokogiri internal XML representation.

## Results

The solution implemented in this project is working properly, but
after some studies (available in the branches `experimental/*` and
`benchmark/*`), it became clear that it can reach almost the same rendering
speed than Nokogiri own builder, even without using `method_missing`.
On the other hand, HTMLess turned out to be impressively fast.

Fortunately, the rendering speed is not so important, once caching strategies
are essential for real systems, and can provide similar response time for all
the studied libraries and implementations.

In other words: choose the lib you like best and apply a good cache strategy.

The results are accessible in the `*.txt` files placed under `benchmark`
forder in `benchmark/*` branches.

## If you have read everything and still want to use NxtBuilder ...

... at your own risk

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'nxt_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nxt_builder

### Usage

```ruby
## XML builder

# You can generate XML by calling render with a block, but remember:
# before using this, you MUST register all the tags that will be used
NxtBuilder::XML.register([:catalog, :cd, :title, :artist, :year])
xml = NxtBuilder::XML.new.render do |r|
  r.catalog do
    r.cd do
      r.title("Ramin")  # text child can be passed as argument
      r.artist { r.text!("Ramin Karimloo") }  # or using the `text!` method
      r.year("2012")
    end
  end
end.to_s

# or ...

# **Prefered way**
# You can subclass the builder and override the `render` method
class CatalogBuilder < NxtBuilder::XML
  register [:catalog, :cd, :title, :artist, :country]

  def render
    catalog do  # inside the class you can access the method directly
      cd do     # => better syntax!
        title { text!("Ramin") }
        artist("Ramin Karimloo")
        year("2012")
      end
  end
end
xml = CatalogBuilder.new.render.to_s

## HTML Builder

# The HTML Builder is similar to XML builder, and can be used in the
# "block mode", or in the "class mode" (prefered).
# The following example illustrate the second one.
#
# Notice: All the HTML5 tags are already registered :)

class HTMLCatalogBuilder < NxtBuilder::HTML
  def new(cds)  # You can pass arguments to the class, in order to build
    @cds = cds  # reusable templates
  end

  def render
    ul class: "catalog" do
      @cds.each do |cd|
        li class: "cd" do
          p(class: "title") { text! cd[:title] }
          p(class: "artist") { text! cd[:artist] }
          p(cd[:year], class: "year")
            # The attributes (named parameters/options)
            # must be the last argument.
            # The content text, on the other hand,
            # must be the first one.
        end
      end
    end
  end
end
html = HTMLCatalogBuilder.new([
  {
    title: "Ramin",
    artist: "Ramin Karimloo",
    year: "2012"
  },
  {
    title: "Feito Pra Acabar",
    artist: "Marcelo Jeneci",
    year: "2010"
  }
]).render.to_s
```

### Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Contributing

Any help will be appreciated. I thank in advance..

1. Fork it ( https://github.com/abravalheri/nxt_builder/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
