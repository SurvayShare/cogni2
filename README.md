# Cogni2

Ruby gem for aws cognito.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cogni2'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cogni2

## Usage

### Client

```ruby
Cogni2::Client.new(**options)
```

```ruby
Options:

domain: Domain of your congito user pool
client_id: Client id
redirect_url: The login redirect url you put in the congito client setting page

```

### Gain token

```ruby
# @param string code
# code would be redirected as a parameter to your redirect url
Cogni2::Client.new(**options).gain_token(code)

# @param string refresh_token
Cogni2::Client.new(**options).request_new_token(refresh_token)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cogni2.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
