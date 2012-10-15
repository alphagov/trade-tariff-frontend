require 'spec_helper'

describe 'Heading page' do
  context 'declarable heading', vcr: { cassette_name: "headings#show_declarable" }  do
    it 'displays declarable related information' do
      visit heading_path("0501")

      page.should have_content 'Importing from outside the EU is subject to a third country duty of 0 %.'
      page.should have_content 'Goods are subject to VAT standard rate.'
    end
  end

  context 'regular heading', vcr: { cassette_name: "headings#show" } do
    it 'should display heading name and children commodities' do
      visit heading_path("0101")

      page.should have_content 'Live horses, asses, mules and hinnies'
      page.should have_content 'Horses'
      page.should have_content 'Pure-bred breeding animals'
    end
  end
end
