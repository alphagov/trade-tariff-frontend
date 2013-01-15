require 'spec_helper'

describe 'Home page' do
  it 'successfully renders the Tariff home page' do
    VCR.use_cassette('geographical_areas#countries') do
      visit root_path

      page.should have_content 'Use the trade tariff'
    end
  end
end
