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

  context 'commodity containing order number without description' do
    it 'renders order number without details properly', vcr: { cassette_name: "commodities#show_5604900010" } do
      visit commodity_path('5604900010', as_of: '2004-10-01')

      page.should have_content 'GSP Confidential Surveillance'
      page.should have_content 'Order No: 421305'
      page.should have_content 'Information on the availability of this quota can be obtained from the Rural Payments Agency.'
    end
  end
end
