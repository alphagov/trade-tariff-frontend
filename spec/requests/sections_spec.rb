require 'spec_helper'

describe 'Sections Index page' do
  it 'should display section names' do
    VCR.use_cassette('geographical_areas#countries') do
      VCR.use_cassette('sections#index') do
        visit sections_path

        page.should have_content 'Live animals; animal products'
        page.should have_content 'Vehicles, aircraft'
      end
    end
  end
end

describe 'Section page' do
  it 'should display section name and chapters in the section' do
    VCR.use_cassette('geographical_areas#countries') do
      VCR.use_cassette('sections#show') do
        visit section_path(1)

        page.should have_content 'Live animals; animal products'
        page.should have_content 'Live animals'
        page.should have_content 'Meat and edible meat offal'
      end
    end
  end
end
