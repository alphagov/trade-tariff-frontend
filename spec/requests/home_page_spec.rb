require 'spec_helper'

describe 'Home page' do
  it 'successfully renders the Tariff home page' do
    visit root_path

    page.should have_content 'Use the tariff'
  end
end
