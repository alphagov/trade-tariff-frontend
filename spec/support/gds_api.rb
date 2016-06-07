require 'gds_api/test_helpers/content_api'

RSpec.configure do |config|
  config.include GdsApi::TestHelpers::ContentApi, :type => :controller
end
