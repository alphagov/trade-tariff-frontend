require 'spec_helper'

describe 'Home page' do
  it 'successfully renders the Tariff home page' do
    VCR.use_cassette('geographical_areas#countries') do
      visit root_path

      page.should have_content 'Use this tool to search'
    end
  end
end
