# fluent-plugin-validate-tag-filter

This plugin validates queue tags and filter them.
Passes through valid one, deletes invalid one.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-validate-tag-filter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-validate-tag-filter

## Usage

```xml
<filter test.**>
  type validate_tag
  max_length 120
  pattern \Atest.[a-z]+.baz\z
</filter>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fluent-plugin-validate-tag-filter. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
