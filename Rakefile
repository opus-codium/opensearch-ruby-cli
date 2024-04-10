# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "github_changelog_generator/task"

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = "opus-codium"
  config.project = "opensearch-ruby-cli"
  config.exclude_labels = %w[dependencies skip-changelog]
  config.future_release = "v#{OpenSearch::CLI::VERSION}"
end

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"

task default: %i[spec standard]
