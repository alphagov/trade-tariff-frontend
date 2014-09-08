ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
require 'simplecov-rcov'

SimpleCov.start 'rails'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'slimmer/test'
require 'gds_api/test_helpers/content_api'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, { debug: true })
end

Capybara.javascript_driver = :poltergeist

Rails.application.routes.default_url_options[:host] = "test.host"

RSpec.configure do |config|
  config.order = :random
  config.infer_base_class_for_anonymous_controllers = false
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.include FactoryGirl::Syntax::Methods
  config.include GdsApi::TestHelpers::ContentApi
  config.include Rails.application.routes.url_helpers
  config.include Capybara::DSL

  config.before(type: :request) do
    stub_content_api_default_artefact
  end
end
