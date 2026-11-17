# frozen_string_literal: true

require "bundler/setup"
require "noun_project_api"
require "faker"
require "json"

require_relative "support/fakes"

# Minimal stand-in for an OAuth HTTP response.
FakeResponse = Struct.new(:code, :body, keyword_init: true)

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.mock_with(:rspec) { |c| c.verify_partial_doubles = true }
  config.order = :random
  Kernel.srand config.seed
  config.formatter = "documentation"
  config.color = true
end
