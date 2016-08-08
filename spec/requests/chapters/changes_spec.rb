require 'spec_helper'

describe 'GET to #index - getting chapter change feed', type: :request do
  let!(:chapter)   { Chapter.new(attributes_for :chapter, goods_nomenclature_item_id: "0101000000") }

  pending 'no request format supplied' do
    before do
      VCR.use_cassette("chapters_changes#index") do
        get "/trade-tariff/chapters/01/changes"
      end
    end

    it 'assumes atom format' do
      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/atom+xml'
    end

    it 'returns chapter changes' do
      expect(response.body).not_to be_empty
      expect(response.body).to match 'measure changes feed for Chapter 01'
    end
  end
end
