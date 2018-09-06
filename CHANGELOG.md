# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2016-06-16
### Added
- Added `ServiceError` class to represent errors returned from Noun Project API with additional `code` and `body` attributes

### Changed
- Changed `Retriever` class' error class from `ArgumentError` to `ServiceError` when responses http code from Noun Project API are other than `200` **BREAKING CHANGE**

## [1.0.0] - 2016-06-16
### Added
- Initial release of `noun-project-api`
