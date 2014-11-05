require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require "bundler/setup"
require "noun-project-api"
require "pry"
require "faker"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = "documentation"
  config.color = true
end
