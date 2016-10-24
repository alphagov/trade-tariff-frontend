require 'spec_helper'

describe 'Home page', type: :request do
  it 'successfully renders the Tariff home page' do
    VCR.use_cassette('geographical_areas#countries') do
      visit root_path

      expect(page).to have_content 'Trade Tariff: look up commodity codes, duty and VAT rates'
      expect(page).to have_selector('meta[name="description"][content="Search for import and export commodity codes and for tax, duty and licences that apply to your goods"]', visible: false)
    end
  end
end
