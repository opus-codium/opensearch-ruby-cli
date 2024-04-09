# OpenSearch::CLI

A wrapper around Ruby's OptionParser to to connect to OpenSearch.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add opensearch-ruby-cli

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install opensearch-ruby-cli

## Usage

Basic usage:

```ruby
require 'opensearch/cli'

cli = OpenSearch::CLI.new
cli.parse!(ARGV)
cli.client.search(index: 'my-index', body: { query: { match_all: {} } })
```

Advanced usage:

```ruby
require 'opensearch/cli'

options = {
  index: 'default'
}

cli = OpenSearch::CLI.new do |opts|
  opts.separator ''
  opts.separator 'Options:'
  opts.on('-i', '--index=INDEX', 'Work on INDEX') do |index|
    options[:index] = index
  end
end
cli.parse!(ARGV)
cli.client.search(index: options[:index], body: { query: { match_all: {} } })
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/opus-codium/opensearch-ruby-cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/opus-codium/opensearch-ruby-cli/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Opensearch::Ruby::Cli project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/opus-codium/opensearch-ruby-cli/blob/main/CODE_OF_CONDUCT.md).
