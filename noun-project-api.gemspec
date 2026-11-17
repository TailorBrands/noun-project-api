# frozen_string_literal: true

require_relative "lib/noun_project_api/version"

Gem::Specification.new do |spec|
  spec.name        = "noun-project-api"
  spec.version     = NounProjectApi::VERSION
  spec.authors     = ["Tailor Engineering"]
  spec.email       = "sloths@tailorbrands.com"

  spec.summary     = "An API wrapper for The Noun Project API's"
  spec.description = "A Gem to expose a wrapping API for The Noun Project API's"
  spec.homepage    = "https://github.com/TailorBrands/noun-project-api"
  spec.license     = "MIT"

  spec.required_ruby_version = ">= 3.4"

  spec.metadata = {
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/master/CHANGELOG.md",
    "bug_tracker_uri" => "#{spec.homepage}/issues"
  }

  spec.files         = Dir["lib/**/*.rb", "README.md", "CHANGELOG.md", "LICENSE"]
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 7.2", "< 9"
  spec.add_dependency "oauth", "~> 1.1"
end
