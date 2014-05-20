source "https://rubygems.org"
source "https://BnrJb6FZyzspBboNJzYZ@gem.fury.io/govuk/"

gem "rails", "3.2.18"

gem "yajl-ruby", "1.2.0", require: "yajl"
gem "faraday"
gem "faraday_middleware"
gem "hashie"

gem "govspeak", "1.2.3"

gem 'gds-api-adapters', '8.2.1'
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
  gem "capybara"
  gem "timecop"
end

group :assets do
  gem "coffee-rails", "~> 3.2.1"
  gem "govuk_frontend_toolkit", "0.32.2"
  gem "jquery-rails"
  gem "sass-rails", "~> 3.2.3"
  gem "therubyracer", "0.12.0"
  gem "uglifier", ">= 1.0.3"
end
