require 'spec_helper'

describe 'GET to #index - getting commodity change feed', type: :request do
  let!(:commodity)   { Commodity.new(attributes_for :commodity, goods_nomenclature_item_id: "0101000000") }

  context 'no request format supplied' do
    before do
      VCR.use_cassette("commodities_changes#index") do
        get "/trade-tariff/commodities/0101210000/changes"
      end
    end

    it 'assumes atom format' do
      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/atom+xml'
    end

    it 'returns commodity changes' do
      expect(response.body).not_to be_empty
      expect(response.body).to match 'measure changes feed for Commodity 0101210000'
    end
  end
end
