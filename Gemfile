source 'https://rubygems.org'
source 'https://gems.gemfury.com/vo6ZrmjBQu5szyywDszE/'

gem 'rails', '3.2.3'

gem 'simple_form'

gem 'mysql2'
gem 'tire'
gem 'kaminari'
gem 'plek'
gem 'simplecov'
gem 'simplecov-rcov'
gem 'ci_reporter'
gem 'test-unit'

if ENV['SLIMMER_DEV']
  gem 'slimmer', path: '../slimmer'
else
  gem 'slimmer', '~> 1.1'
end

if ENV['API_DEV']
  gem 'gds-api-adapters', path: '../gds-api-adapters'
else
  gem 'gds-api-adapters', '~> 0.0.43'
end

gem 'spreadsheet'

gem 'unicorn'

group :development do
  gem 'capistrano'
  gem 'debugger'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'forgery'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'fakeweb'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-rails'
  gem "therubyracer"
end
