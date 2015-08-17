# Change Log

## [release_754...release_776](https://github.com/alphagov/trade-tariff-frontend/compare/release_754...release_776)
### Changed
- Upgraded Ruby version to 2.2.2
- Upgraded Rails version to 4.2.3
- GOVUK Classic removed
- API request_forwarder now passes on query strings so we can do pagenatination  
- Fix licences typo

### Added
- Links to Volume 1 and 3

### Removed
- Need IDs custom dimension not used anymore

## [release_742...release_754](https://github.com/alphagov/trade-tariff-frontend/compare/release_742...release_754)
### Changed
- Modified padding between letters in az-index
- Modified padding for .related-module
- Fixed bundler audit in production
- Corrected copyright notice
- Anonymized the IP addresses in UA
- Upgraded Ruby version to 2.2.1
- Upgraded Rails version to 4.2
- Upgraded gds-api-adapters, govspeak, rspec, capistrano among others

### Added
- Used frontend_toolkit analytics

## [release_727...release_742](https://github.com/alphagov/trade-tariff-frontend/compare/release_727...release_742)
### Changed
- Removed slimmer, now just using govuk_template
- upgrades to breakman and sprockets

### Added
- default rake task which runs the specs
- specs for the A-Z
- bundler-audit added to check for security vulnerabilities

## [release_707...release_727](https://github.com/alphagov/trade-tariff-frontend/compare/release_707...release_727)
### Changed
- Upgrade Rails to 4.1.8 from 3.2.18
- Upgrade Ruby to 2.1.4 from 1.9.3
- Update slimmer from 3.25.0 to 5.0.1. Fixing the MetaViewportRemover and adds
  "Is there anything wrong with this page?"

### Added
- Show the last successful sync date using "Last updated:"
