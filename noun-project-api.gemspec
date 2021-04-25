# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "date"

Gem::Specification.new do |s|
  s.name        = "noun-project-api"
  s.version     = "3.1.1"
  s.platform    = Gem::Platform::RUBY
  s.date        = Date.today.to_s
  s.summary     = "An API wrapper for The Noun Project API's"
  s.description = "A Gem to expose a wrapping API for The Noun Project API's"
  s.authors     = ["Tailor Engineering"]
  s.email       = "sloths@tailorbrands.com"
  s.homepage    = "https://github.com/TailorBrands/noun-project-api"
  s.license     = "MIT"

  s.files        = Dir["README.rdoc", "VERSION", "MIT-LICENSE", "Rakefile", "lib/**/*"]
  s.test_files   = Dir["spec/**/*"]

  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "oauth", "~> 0.5"

  s.add_development_dependency "faker", "~> 2.13"
  s.add_development_dependency "pry", "~> 0.13"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.9"
  s.add_development_dependency "rspec_junit_formatter", "~> 0.4"
  s.add_development_dependency "rubocop", "0.79.0"
end
