require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rubygems/package_task'
require 'rspec/core/rake_task'

spec = eval(File.read('env_paths.gemspec')) # rubocop:disable Lint/Eval

Gem::PackageTask.new(spec)
RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task default: %w[rubocop spec]
