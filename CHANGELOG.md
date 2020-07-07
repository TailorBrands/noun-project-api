# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.1.0] - 2020-07-10
### Changed
- Changed is_published attribute to published
- rubocop update and fixes
- Switch to symbol based hash access
- Dropped semver gem
- Gem updates
- Add cache TTL support.

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
