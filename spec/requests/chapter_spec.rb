require 'spec_helper'

describe 'Chapter page', vcr: { cassette_name: "chapters#show" }   do
  it 'should display chapter name and headings in the chapter' do
    visit chapter_path("01")

    page.should have_content 'Live animals'
    page.should have_content 'Live bovine animals'
    page.should have_content 'Live swine'
  end
end
