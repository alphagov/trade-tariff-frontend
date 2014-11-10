source "https://rubygems.org"

gem "rails", "3.2.19"

gem "yajl-ruby"
gem "multi_json"
gem "httparty"
gem "hashie"
gem "govspeak", "1.2.3"

gem "gds-api-adapters", "14.4.0"
gem "plek", "1.3.1"
gem "slimmer", "3.25.0"
gem "addressable"

gem "unicorn", "~> 4.6.3"

gem "ci_reporter"
gem "logstasher", '0.4.8'
gem "airbrake", "3.1.16"

group :development, :test do
  gem "pry-rails"
end

group :development do
  gem "capistrano"
end

group :test do
  gem "brakeman", "~> 1.7.0"
  gem "webmock", "~> 1.11.0"
  gem "factory_girl_rails"
  gem "forgery"
  gem "shoulda-matchers"
  gem "vcr"
  gem "simplecov", "~> 0.6.4"
  gem "simplecov-rcov", "~> 0.2.3"
  gem "rspec-rails"
  gem "capybara", "~> 2.4.1"
  gem "poltergeist", "~> 1.5.1"
  gem "phantomjs", "~> 1.9.7.1", require: "phantomjs/poltergeist"
  gem "timecop"
end

group :assets, :test do
  gem "coffee-rails", "~> 3.2.1"
  gem "govuk_frontend_toolkit", "1.5.0"
  gem "jquery-rails"
  gem "sass-rails", "~> 3.2.6"
  gem "therubyracer", "0.12.0"
  gem "uglifier", ">= 1.0.3"
end
