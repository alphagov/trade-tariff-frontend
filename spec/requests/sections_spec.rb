require 'spec_helper'

describe 'Sections Index page', vcr: { cassette_name: "sections#index" }  do
  it 'should display section names' do
    visit sections_path

    page.should have_content 'Live animals; animal products'
    page.should have_content 'Vehicles, aircraft'
  end
end

describe 'Section page', vcr: { cassette_name: "sections#show" }   do
  it 'should display section name and chapters in the section' do
    visit section_path(1)

    page.should have_content 'Live animals; animal products'
    page.should have_content 'Live animals'
    page.should have_content 'Meat and edible meat offal'
  end
end
