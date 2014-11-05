require 'bundler'
Bundler::GemHelper.install_tasks

$:.unshift 'lib'

desc 'Default: run unit tests.'
task :default => [:spec]

require 'rspec/core/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end
