# Change Log

## [August 05, 2016]

### Added
- Add connection pool for memcached.
- Add Slack notifications from the deploy script.
- Add the `rack-timeout` gem.
- Set the server name for `Raven`.
- Add custom errors pages instead of default pages from rails.
- Add noindex metatag on atom feeds.
- Add attribute rel="nofollow" to changes links.

### Changed
- Update `SearchReferencePresenter` to not expect the `referenced` association.
- Update deploy script.
- Update logs format.
- Update `dalli` gem.
- Update `puma` gem.
- Implement low level caching to backend requests.
- Simplify Search#countries method.
- Add maintance mode page, redirect if `MAINTENANCE` env var is present.
- MultiJson.engine now uses `yajl`.
- Now the links persist the query-string of the date and country.

### Fixed
- Fix issue with n+1 requests to the backend API.

### Removed
- Remove the `therubyracer` gem.
- Remove ci reporter rake tasks.

[August 05, 2016]: https://github.com/bitzesty/trade-tariff-frontend/compare/bcb1ea1...58633f0

## [July 25, 2016]

### Added
- Add `newrelic`.
- Ensure `puma` establishes the connection on boot.
- Add `dalli` gem.
- Add `lograge` gem and configuration.
- Ignore from git all CloudFoundry manifest files.
- Add deploy script.

### Changed
- Update `ruby` version to `2.3.1`.
- Update `sentry-raven`.
- Switch to use memcached, use `dalli` as cache_store.
- Enable threadsafe mode in production.
- Update README.
- Update puma configuration to have 1 worker by default.


### Fixed
- Fix issue with the proxy to backend.
- Fix issue with duplicated titles.

### Removed
- Remove hard-coded text about changes in procedures.
- Remove `jenkins.sh` file.

[July 25, 2016]: https://github.com/bitzesty/trade-tariff-frontend/compare/69114b5...1c74294


## [June 16, 2016]

### Added
- Add `rspec_junit_formatter` gem.
- Add `secrets.yml` file.
- Add `.cfignore` file as a symlink of the `.gitignore` file.
- Add `rails_12factor` gem.


### Changed
- Switch from Travis to CircleCI.
- Update `ruby` version to `2.2.3`.
- Prepare the application to work in CloudFoundry.
- Switch from `Unicorn` to `Puma`.
- Update `govuk_template` gem.
- Update `govuk_frontend_toolkit` gem.
- Update headings partial to use `formatted_description`.
- Update `README`.
- Replace Airbrake with Sentry.

### Fixed
- Unescape content in additional code description.
- Fix issues with Dates and timezones
- Fix vcr cassette with missing `formatted_description`
 key.

### Removed
- Remove travis configuration file.
- Remove logstasher.
- Remove capistrano.
- Remove `govuk_artefact` dependency.

[June 16, 2016]: https://github.com/bitzesty/trade-tariff-frontend/compare/eb1f40b...69114b5


## [March 01, 2016]

### Added
- Display the country code in the measures collection.
- Add a link to GOV.UK's Terms and Conditions to the footer.
- Add codeclimate configuration file.
- Paragraph added so the users will know about the import, export and storage procedures are changing.

### Changed
- `nokogiri` gem updated.
- Upgrade `rails` to `4.2.5.2`
- `govuk_template` gem updated.
- Use bearer token for publishing API authentication.

### Removed
- Remove the `bundler-audit` gem and rake task.
- Remove redundant precompiled assets

[March 01, 2016]: https://github.com/bitzesty/trade-tariff-frontend/compare/58633f0...eb1f40b

## [September 23, 2015]

### Added
- Rake task to register special routes.
- Meta description to trade tariff

### Changed
- `gds-api-adapters` gem updated.
- `uglifier` gem updated.
- Update README

### Fixed
- Fix broken background image in the tariff styles.

### Removed
- Remove panopticon registration

[September 23, 2015]: https://github.com/bitzesty/trade-tariff-frontend/compare/bcb1ea1...58633f0

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
