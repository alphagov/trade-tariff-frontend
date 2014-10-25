require 'spec_helper'

describe 'Chapter page', type: :request do
  context 'as HTML' do
    it 'should display chapter name and headings in the chapter' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('chapters#show') do
          visit chapter_path("01")

          page.should have_content 'Live animals'
          page.should have_content 'Live bovine animals'
          page.should have_content 'Live swine'
        end
      end
    end
  end

  context 'as JSON' do
    context 'requested with json format' do
      it 'renders direct API response' do
        VCR.use_cassette('chapters#show_01_api_json_format') do
          get "/trade-tariff/chapters/01.json"

          json = JSON.parse(response.body)

          expect(json["goods_nomenclature_item_id"]).to eq '0100000000'
          expect(json["formatted_description"]).to eq 'Live animals'
        end
      end
    end

    context 'requested with json HTTP Accept header' do
      it 'renders direct API response' do
        VCR.use_cassette('chapters#show_01_api_json_content_type') do
          get "/trade-tariff/chapters/01", {}, { 'HTTP_ACCEPT' => 'application/json' }

          json = JSON.parse(response.body)

          expect(json["goods_nomenclature_item_id"]).to eq '0100000000'
          expect(json["formatted_description"]).to eq 'Live animals'
        end
      end
    end
  end
end
