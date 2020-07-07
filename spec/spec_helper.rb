# frozen_string_literal: true

require "bundler/setup"
require "noun_project_api"
require "pry"
require "faker"
require "json"

require_relative "support/fakes"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = "documentation"
  config.color = true
end
