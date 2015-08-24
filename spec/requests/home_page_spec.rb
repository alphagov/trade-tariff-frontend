require 'spec_helper'

describe 'Home page', type: :request do
  it 'successfully renders the Tariff home page' do
    VCR.use_cassette('geographical_areas#countries') do
      visit root_path

      expect(page).to have_content 'Use this tool to search'
      expect(page).to have_selector(%Q{meta[name='description'][content="Search for import and export commodity codes and for tax, duty and licences that apply to your goods"]}, visible: false)
    end
  end
end
