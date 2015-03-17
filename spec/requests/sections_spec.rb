require 'spec_helper'

describe 'Sections Index page', type: :request do
  context 'as HTML' do
    it 'should display section names' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('sections#index') do
          visit sections_path

          expect(page).to have_content 'Live animals; animal products'
          expect(page).to have_content 'Vehicles, aircraft'
        end
      end
    end
  end

  context 'as JSON' do
    context 'requested with json format' do
      it 'renders direct API response' do
        VCR.use_cassette('sections#index_api_json_format') do
          get "/trade-tariff/sections.json"

          json = JSON.parse(response.body)

          expect(json).to be_kind_of Array
          expect(json.first['title']).to eq 'Live animals; animal products'
        end
      end
    end

    context 'requested with json HTTP Accept header' do
      it 'renders direct API response' do
        VCR.use_cassette('sections#index_api_json_content_type') do
          get "/trade-tariff/sections", {}, { 'HTTP_ACCEPT' => 'application/json' }

          json = JSON.parse(response.body)

          expect(json).to be_kind_of Array
          expect(json.first['title']).to eq 'Live animals; animal products'
        end
      end
    end
  end
end

describe 'Section page', type: :request do
  context 'as HTML' do
    it 'should display section name and chapters in the section' do
      VCR.use_cassette('geographical_areas#countries') do
        VCR.use_cassette('sections#show') do
          visit section_path(1)

          expect(page).to have_content 'Live animals; animal products'
          expect(page).to have_content 'Live animals'
          expect(page).to have_content 'Meat and edible meat offal'
        end
      end
    end
  end

  context 'as JSON' do
    context 'requested with json format' do
      it 'renders direct API response' do
        VCR.use_cassette('sections#show_1_api_json_format') do
          get "/trade-tariff/sections/1.json"

          json = JSON.parse(response.body)

          expect(json['title']).to eq 'Live animals; animal products'
          expect(json['chapters']).to be_kind_of Array
        end
      end
    end

    context 'requested with json HTTP Accept header' do
      it 'renders direct API response' do
        VCR.use_cassette('sections#show_1_api_json_content_type') do
          get "/trade-tariff/sections/1", {}, { 'HTTP_ACCEPT' => 'application/json' }

          json = JSON.parse(response.body)

          expect(json['title']).to eq 'Live animals; animal products'
          expect(json['chapters']).to be_kind_of Array
        end
      end
    end
  end
end
