require 'spec_helper'

describe 'Heading page' do
  context 'declarable heading' do
    context 'without country filter' do
      it 'displays declarable related information' do
        VCR.use_cassette('geographical_areas#countries') do
          VCR.use_cassette('headings#show_declarable') do
            visit heading_path("0501")

            page.should have_content 'Importing from outside the EU is subject to a third country duty of 0.00 %.'
            page.should have_content 'Goods are subject to VAT standard rate.'
          end
        end
      end
    end

    context 'with country filter' do
      it 'displays declarable related information' do
        VCR.use_cassette('geographical_areas#countries') do
          VCR.use_cassette('headings#show_declarable') do
            visit heading_path("0501", country: 'ZW')

            within("#import table.specific-countries") do
              page.should_not     have_content 'Zimbabwe'
              page.should_not     have_content 'Eastern and Southern Africa States' # Zimbabwe is member of latter
            end

            within("#import table.country-filter") do
              page.should     have_content 'Zimbabwe'
              page.should     have_content 'Eastern and Southern Africa States' # Zimbabwe is member of latter
            end
          end
        end
      end
    end
  end

  context 'regular heading' do
    it 'should display heading name and children commodities' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('headings#show') do
          visit heading_path("0101")

          page.should have_content 'Live horses, asses, mules and hinnies'
          page.should have_content 'Horses'
          page.should have_content 'Pure-bred breeding animals'
        end
      end
    end
  end
end
