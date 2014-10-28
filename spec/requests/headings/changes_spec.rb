require 'spec_helper'

describe 'GET to #index - getting heading change feed', type: :request do
  let!(:heading)   { Heading.new(attributes_for :heading, goods_nomenclature_item_id: "0101000000") }

  context 'no request format supplied' do
    before do
      VCR.use_cassette("headings_changes#index") do
        get "/trade-tariff/headings/0101/changes"
      end
    end

    it 'assumes atom format' do
      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/atom+xml'
    end

    it 'returns heading changes' do
      expect(response.body).not_to be_empty
      expect(response.body).to match 'measure changes feed for Heading 0101'
    end
  end
end
