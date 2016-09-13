source "https://rubygems.org"
ruby "2.3.1"

gem "rails", "4.2.7.1"

gem "yajl-ruby", "~> 1.2", require: "yajl"
gem "multi_json", "~> 1.11"
gem "httparty", "~> 0.13"
gem "hashie", "~> 3.4"
gem "govspeak", "~> 3.6"

gem "govuk_template", "~> 0.18"
gem "plek", "~> 1.11"
gem "addressable", "~> 2.3"

gem "coffee-rails", "~> 4.1"
gem "govuk_frontend_toolkit", "~> 4.14"
gem 'govuk_elements_rails', '~> 1.2', '>= 1.2.2'
gem "jquery-rails", "~> 3.1.3"
gem 'jquery-migrate-rails'
gem "sass-rails", "~> 5.0"
gem "uglifier", "~> 2.7"
gem "responders", "~> 2.1"
gem "bootscale", "~> 0.5", require: false

# Logging
gem "logstash-event"
gem "lograge"

# Web Server
gem "puma"
gem "rack-timeout", "~> 0.4"

# Memcache
gem "dalli", "~> 2.7"
gem "connection_pool", "~> 2.2"

group :development do
  gem "web-console"
end

group :development, :test do
  gem "quiet_assets"
  gem "pry-rails"
end

group :test do
  gem "webmock", "~> 1.21"
  gem "factory_girl_rails"
  gem "forgery"
  gem "shoulda-matchers"
  gem "vcr"
  gem "simplecov", "~> 0.10"
  gem "simplecov-rcov", "~> 0.2.3"
  gem "rspec-rails", "~> 3.2"
  gem "capybara", "~> 2.4"
  gem "poltergeist", "~> 1.6"
  gem "timecop", "~> 0.8"
  gem "rspec_junit_formatter"
end

group :production do
  gem "rails_12factor"
  gem "sentry-raven"
  gem "newrelic_rpm"
end
