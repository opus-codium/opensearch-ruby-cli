# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in opensearch-ruby-cli.gemspec
gemspec

gem "github_changelog_generator"

gem "rake", "~> 13.0"

gem "rspec", "~> 3.0"

gem "standard", "~> 1.3"

group :development do
  # FIXME: Relax this version when the stardand gem can cope with empty collection annotations
  # https://github.com/soutaro/steep/pull/1338
  # https://github.com/standardrb/standard/pull/656
  gem "steep", "< 1.9.0", require: false
end
