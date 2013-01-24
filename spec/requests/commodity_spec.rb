require 'spec_helper'

describe 'Commodity page' do
  context 'basic commodity' do
    it 'displays declarable related information' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('commodities#show_0101300000') do
          visit commodity_path("0101300000")

          page.should have_content 'Importing from outside the EU is subject to a third country duty of 7.70 %'
          page.should have_content 'Goods are subject to VAT standard rate.'
        end
      end
    end
  end

  context 'commodity with complex rendering of additional code / measure conditions' do
    it 'displays declarable related information' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('commodities#show_8714930019') do
          visit commodity_path("8714930019")

          page.should have_content 'Importing from outside the EU is subject to a third country duty of 4.70 %.'
          page.should have_content 'Goods are subject to VAT standard rate.'
        end
      end
    end
  end

  context 'commodity with country filter' do
    it 'will not display measures for other countries except for selected one' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('commodities#show_0101300000') do
          visit commodity_path("0101300000", country: "AD")

          within("#import") do
            page.should     have_content 'Andorra'
            page.should_not have_content 'Albania'
            page.should_not have_content 'Chile'
          end
        end
      end
    end
  end

  context 'commodity with complex measure condition requirements' do
    it 'renders successfully' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('commodities#show_1701910000_2006-02-01') do
          visit commodity_path("1701910000", as_of: "2006-02-01")

          within("#import") do
            page.should have_content 'Additional duty based on cif price'
          end
        end
      end
    end
  end

  context 'commodity with national measurement units' do
    pending
  end
end
