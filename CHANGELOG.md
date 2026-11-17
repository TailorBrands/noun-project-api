# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [5.0.1] - 2026-11-17
### Fixed
- Requests fail with `OAuth::Error` (cross-origin URI not permitted) when the bundle resolves oauth 1.1.9,
  which refuses signed requests to an origin other than the consumer's site. The OAuth consumer is now
  configured with `site: API_BASE`; the signed requests sent are byte-identical to before.

## [5.0.0] - 2026-11-17
No change to the public API or runtime behavior; the major bump is for the Ruby floor.

### Changed
- **BREAKING:** Requires Ruby >= 3.4 (was >= 3.2). Development Ruby is 3.4.12.
- Version now lives in `NounProjectApi::VERSION` (`lib/noun_project_api/version.rb`).
- Gemspec follows current conventions: `add_dependency`, rubygems metadata URIs, and the packaged
  files are now `lib/`, `README.md`, `CHANGELOG.md` and `LICENSE` (it listed files that did not exist).
- Development dependencies moved to the `Gemfile` and upgraded to their latest releases
  (rspec 3.13, rubocop 1.92 with rubocop-rspec 3.10, faker 3.8, rake 13.4), bundled with Bundler 4.1.
- Specs modernized (`described_class`, `let`, spies, `Struct` in place of `OpenStruct`), with added
  coverage for search caching, error responses and Marshal round-trip of cached icons.

### Removed
- Travis CI config (CI runs on GitHub Actions).

## [3.1.0] - 2020-07-10
### Changed
- Changed is_published attribute to published
- rubocop update and fixes
- Switch to symbol based hash access
- Dropped semver gem
- Gem updates
- Add cache TTL support.
- Switched to Github actions

## [3.0.0] - 2020-07-10
### Changed
- Updated to Ruby 2.7.1
- Add cache support.

## [2.0.1] - 2018-09-06
### Changed
- Changed `IconRetriever` class' error class from `ArgumentError` to `ServiceError` when responses http code from Noun Project API are other than `200` **BREAKING CHANGE**

## [2.0.0] - 2018-09-06
### Added
- Added `CHANGELOG.md`
- Added `ServiceError` class to represent errors returned from Noun Project API with additional `code` and `body` attributes

### Changed
- Changed `Retriever` class' error class from `ArgumentError` to `ServiceError` when responses http code from Noun Project API are other than `200` **BREAKING CHANGE**

### Removed
- Removed CircleCI support
- Dropped Rubinius (rbx-2) support
- Dropped Ruby 1.9 support

## [1.0.0] - 2016-06-16
### Added
- Initial release of `noun-project-api`
