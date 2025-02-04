# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "date"

Gem::Specification.new do |s|
  s.name        = "noun-project-api"
  s.version     = "4.0.3"
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

  s.required_ruby_version = ">= 3.2"

  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "oauth", "~> 1.1"

  s.add_development_dependency "faker", "~> 3.1"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.12"
  s.add_development_dependency "rubocop", "~> 1"
end
