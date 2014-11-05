require "bundler/setup"
require "noun-project-api"
require "pry"

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.formatter = "documentation"
  config.color = true
  config.fail_fast = true unless ENV["CI"]
end
