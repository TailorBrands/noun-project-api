require "bundler/setup"
require "noun-project-api"
require "pry"
require "faker"
require 'json'

require_relative "support/fakes"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = "documentation"
  config.color = true
end
