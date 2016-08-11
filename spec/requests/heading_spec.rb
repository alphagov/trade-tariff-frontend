require 'spec_helper'

describe 'Heading page', type: :request do
  context 'as HTML' do
    context 'declarable heading' do
      context 'without country filter' do
        it 'displays declarable related information' do
          VCR.use_cassette('geographical_areas#countries') do
            VCR.use_cassette('headings#show_declarable') do
              visit heading_path("0501")

              expect(page).to have_content 'Importing from outside the EU is subject to a third country duty of 0.00 % unless subject to other measures.'
              expect(page).to have_content 'Goods are subject to VAT standard rate.'
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
                expect(page).to_not     have_content 'Zimbabwe'
                expect(page).to_not     have_content 'Eastern and Southern Africa States' # Zimbabwe is member of latter
              end

              within("#import table.country-filter") do
                expect(page).to     have_content 'Zimbabwe'
                expect(page).to     have_content 'Eastern and Southern Africa States' # Zimbabwe is member of latter
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

            expect(page).to have_content 'Live horses, asses, mules and hinnies'
            expect(page).to have_content 'Horses'
            expect(page).to have_content 'Pure-bred breeding animals'
          end
        end
      end
    end
  end

  context 'as JSON' do
    context 'requested with json format' do
      it 'renders direct API response' do
        VCR.use_cassette('headings#show_0101_api_json_format') do
          get "/trade-tariff/headings/0101.json"

          json = JSON.parse(response.body)

          expect(json['goods_nomenclature_item_id']).to eq '0101000000'
          expect(json['commodities']).to be_kind_of Array
        end
      end
    end

    context 'requested with json HTTP Accept header' do
      it 'renders direct API response' do
        VCR.use_cassette('headings#show_0101_api_json_content_type') do
          get "/trade-tariff/headings/0101", {}, { 'HTTP_ACCEPT' => 'application/json' }

          json = JSON.parse(response.body)

          expect(json['goods_nomenclature_item_id']).to eq '0101000000'
          expect(json['commodities']).to be_kind_of Array
        end
      end
    end
  end
end
