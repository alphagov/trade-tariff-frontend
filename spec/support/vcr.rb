require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec', 'vcr')
  c.hook_into :webmock
  # c.debug_logger = $stdout
  c.default_cassette_options = { match_requests_on: [:path] }
  c.configure_rspec_metadata!
end
