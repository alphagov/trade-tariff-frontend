require 'spec_helper'

describe 'Commodity page', type: :request do
  context 'basic commodity' do
    context 'as HTML' do
      it 'displays declarable related information' do
        VCR.use_cassette('geographical_areas#countries') do
          VCR.use_cassette('commodities#show_0101300000') do
            visit commodity_path("0101300000")

            expect(page).to have_content 'Importing from outside the EU is subject to a third country duty of 7.70 %'
            expect(page).to have_content 'Goods are subject to VAT standard rate.'
          end
        end
      end
    end

    context 'as JSON' do
      context 'requested with json format' do
        it 'renders direct API response' do
          VCR.use_cassette('commodities#show_0101300000_api_json_format') do
            get "/trade-tariff/commodities/0101300000.json"

            json = JSON.parse(response.body)

            expect(json["declarable"]).to be true
            expect(json["import_measures"]).to be_kind_of Array
          end
        end
      end

      context 'requested with json HTTP Accept header' do
        it 'renders direct API response' do
          VCR.use_cassette('commodities#show_0101300000_api_json_content_type') do
            get "/trade-tariff/commodities/0101300000", {}, { 'HTTP_ACCEPT' => 'application/json' }

            json = JSON.parse(response.body)

            expect(json["declarable"]).to be true
            expect(json["import_measures"]).to be_kind_of Array
          end
        end
      end
    end
  end

  context 'commodity with complex rendering of additional code / measure conditions' do
    it 'displays declarable related information' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('commodities#show_8714930019') do
          visit commodity_path("8714930019")

          expect(page).to have_content 'Importing from outside the EU is subject to a third country duty of 4.70 %.'
          expect(page).to have_content 'Goods are subject to VAT standard rate.'
        end
      end
    end
  end

  context 'commodity with country filter' do
    it 'will not display measures for other countries except for selected one' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('commodities#show_0101300000') do
          visit commodity_path("0101300000", country: "AD")

          within("#import table.specific-countries") do
            expect(page).to_not     have_content 'Andorra'
            expect(page).to have_content 'Albania'
            expect(page).to have_content 'Chile'
          end

          within("#import table.country-filter") do
            expect(page).to     have_content 'Andorra'
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
            expect(page).to have_content 'Additional duty based on cif price'
          end
        end
      end
    end
  end

  context 'commodity with national measurement units' do
    it 'renders successfully' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('commodities#show_2208909110') do
          visit commodity_path("2208909110")

          within("#import") do
            expect(page).to     have_content 'l alc. 100%'
          end
        end
      end
    end
  end
end
