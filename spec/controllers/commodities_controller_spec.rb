require 'spec_helper'

describe CommoditiesController, "GET to #show" do
  context 'existing commodity id provided', vcr: { cassette_name: "commodities#show" } do
    let!(:commodity)   { Commodity.new(attributes_for :commodity) }

    before(:each) do
      get :show, id: commodity.short_code
    end

    it { should respond_with(:success) }
    it { should assign_to(:section) }
    it { should assign_to(:chapter) }
    it { should assign_to(:heading) }
    it { should assign_to(:commodity) }
  end

  context 'with too long commodity id provided', vcr: { cassette_name: "commodities#show_01012100001234" } do
    let(:commodity_id) { '01012100001234' } # commodity 0101210000 does exist

    before(:each) do
      get :show, id: commodity_id
    end

    it 'redirects to heading page (strips exceeding heading id characters)' do
      expect(response.status).to eq 302
      expect(response.location).to eq commodity_url(id: commodity_id.first(10))
    end
  end

  context 'with non existing commodity id provided', vcr: { cassette_name: "commodities#show_0101999999" } do
    let(:commodity_id) { '0101999999' } # commodity 0101999999 does not exist

    before(:each) do
      get :show, id: commodity_id
    end

    it 'redirects to heading page (strips exceeding commodity id characters)' do
      expect(response.status).to eq 302
      expect(response.location).to eq heading_url(id: commodity_id.first(4))
    end
  end

  context 'with commodity id that does not exist in provided date', vcr: { cassette_name: "commodities#show_010121000_2000-01-01" } do
    let(:commodity_id) { '0101210000' } # commodity 0101210000 does not exist at 1st of Jan, 2000

    before(:each) do
      get :show, id: commodity_id, as_of: Date.new(2000,1,1)
    end

    it 'redirects to actual version of the commodity page' do
      expect(response.status).to eq 302
      expect(response.location).to eq commodity_url(
        id: commodity_id.first(10)
      )
    end
  end
end
