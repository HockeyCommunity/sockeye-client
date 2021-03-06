# 🐟 Sockeye::Client

This project is currently under development, and is not usable. Please check back soon.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sockeye-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sockeye-client

## Usage

```ruby
def on_message(message)
  puts "message:"
  puts message.inspect
end

def on_error(code)
  puts "error:"
  puts code.inspect
end

def on_close
  puts "closed"
end

Sockeye::Client.new(
  server_address: "ws://sockeye.local:8443", 
  auth_token:     "THIS USER'S AUTH TOKEN", 
  on_message:     Proc.new {|message| on_message(message)}, 
  on_error:       Proc.new {|code| on_error(code)}, 
  on_close:       Proc.new {on_close}
).connect
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sockeye-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

