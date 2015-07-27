# Rack::Prefer

Simple gem that parses the [HTTP prefer header](http://tools.ietf.org/html/rfc7240).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-prefer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-prefer

## Usage

```ruby
# rack app (sinatra, lotus, grape etc)
require 'rack/prefer'
```

Rails automatically includes the `rack/prefer` file.

Once you have access to Rack::Request object (Rails ActionDispatch::Request object
inherits from Rack's Rack::Request) you also have access to Prefer header. So for
a request like the following prefer headers:

```http
Prefer: respond-async, wait=10
Prefer: priority=5
Prefer: handling=strict
```

you can do:
```ruby
request.prefer.values #{"respond-async"=>nil, "wait"=>"10", "priority"=>"5"}
request.prefer.response_async? #true
request.prefer.return_minimal? #false
request.prefer.wait? #true
request.prefer.wait # 10 (integer)
request.prefer.handling_strict? #true
request.prefer.values['handling'] #'strict'
#Rails only
request.prefer.values[:handling] #strict
```

Happy coding!


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. 

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rack-prefer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
