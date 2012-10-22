require 'spec_helper'

describe 'Commodity page' do
  context 'basic commodity' do
    it 'displays declarable related information', vcr: { cassette_name: "commodities#show_0101300000" } do
      visit commodity_path("0101300000")

      page.should have_content 'Importing from outside the EU is subject to a third country duty of 7.70 %'
      page.should have_content 'Goods are subject to VAT standard rate.'
    end
  end

  context 'commodity with complex rendering of additional code / measure conditions' do
    it 'displays declarable related information', vcr: { cassette_name: "commodities#show_8714930019" } do
      visit commodity_path("8714930019")

      page.should have_content 'Importing from outside the EU is subject to a third country duty of 4.70 %.'
      page.should have_content 'Goods are subject to VAT standard rate.'
    end
  end
end
