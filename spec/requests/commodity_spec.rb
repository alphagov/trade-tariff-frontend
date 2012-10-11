require 'spec_helper'

describe 'Commodity page' do
  it 'displays declarable related information', vcr: { cassette_name: "commodities#show" } do
    visit commodity_path("0101300000")

    page.should have_content 'Importing from outside the EU is subject to a third country duty of 7.7 %'
    page.should have_content 'Goods are subject to VAT standard rate.'
  end
end
