# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

require 'semver'
require 'date'

Gem::Specification.new do |s|
  s.name        = 'noun-project-api'
  s.version     = SemVer.find.format '%M.%m.%p'
  s.platform    = Gem::Platform::RUBY
  s.date        = Date.today.to_s
  s.summary     = "An API wrapper for The Noun Project API's"
  s.description = "A Gem to expose a wrapping API for The Noun Project API's"
  s.authors     = ["Nadav Shatz"]
  s.email       = 'nadav@tailorbrands.com'
  s.homepage    = 'https://github.com/TailorBrands/noun-project-api'
  s.license     = 'MIT'

  s.files        = Dir['README.rdoc', 'VERSION', 'MIT-LICENSE', 'Rakefile', 'lib/**/*']
  s.test_files   = Dir['spec/**/*']

  s.add_runtime_dependency 'oauth', '~> 0.5'
  s.add_runtime_dependency 'activesupport'

  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'faker', '~> 2.13'
  s.add_development_dependency 'semver', '~> 1.0'
  s.add_development_dependency 'rspec_junit_formatter', '~> 0.4'
  s.add_development_dependency 'pry', '~> 0.13'
end
