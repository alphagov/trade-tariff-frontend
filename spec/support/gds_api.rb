require 'gds_api/test_helpers/panopticon'

RSpec.configure do |config|
  config.include GdsApi::TestHelpers::Panopticon, :type => :controller
  config.before :each, :type => :controller do
    stub_panopticon_default_artefact
  end
end
