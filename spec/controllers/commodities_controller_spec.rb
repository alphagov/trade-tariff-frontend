require 'spec_helper'

describe CommoditiesController, "GET to #show", type: :controller do
  context 'existing commodity id provided', vcr: { cassette_name: "commodities#show" } do
    let!(:commodity)   { Commodity.new(attributes_for :commodity) }

    before(:each) do
      get :show, id: commodity.short_code
    end

    subject { controller }

    it { should respond_with(:success) }
    it { expect(assigns(:section)).to be_present }
    it { expect(assigns(:chapter)).to be_present }
    it { expect(assigns(:heading)).to be_present }
    it { expect(assigns(:commodity)).to be_present }
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

    around(:each) do |example|
      Timecop.freeze(Date.new(2013,11,11)) do
        example.run
      end
    end

    before(:each) do
      get :show, id: commodity_id, year: 2000, month: 1, day: 1, country: nil
    end

    it 'redirects to actual version of the commodity page' do
      expect(response.status).to eq 302
      expect(response.location).to eq commodity_url(
        id: commodity_id.first(10),
        year: 2013,
        month: 11,
        day: 11
      )
    end
  end
end
