require 'spec_helper'

describe 'Commodity page' do
  context 'basic commodity' do
    it 'displays declarable related information', vcr: { cassette_name: "commodities#show_0101300000" } do
      VCR.use_cassette('geographical_areas#countries') do
        visit commodity_path("0101300000")

        page.should have_content 'Importing from outside the EU is subject to a third country duty of 7.70 %'
        page.should have_content 'Goods are subject to VAT standard rate.'
      end
    end
  end

  context 'commodity with complex rendering of additional code / measure conditions' do
    it 'displays declarable related information', vcr: { cassette_name: "commodities#show_8714930019" } do
      VCR.use_cassette('geographical_areas#countries') do
        visit commodity_path("8714930019")

        page.should have_content 'Importing from outside the EU is subject to a third country duty of 4.70 %.'
        page.should have_content 'Goods are subject to VAT standard rate.'
      end
    end
  end

  context 'commodity with country filter', vcr: { cassette_name: "commodities#show_0101300000" } do
    it 'will not display measures for other countries except for selected one' do
      VCR.use_cassette('geographical_areas#countries') do
        visit commodity_path("0101300000", country: "AD")

        within("#measures-js") do
          page.should     have_content 'Andorra'
          page.should_not have_content 'Albania'
          page.should_not have_content 'Chile'
        end
      end
    end
  end
end
