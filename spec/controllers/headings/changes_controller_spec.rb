require 'spec_helper'

describe Headings::ChangesController, "GET to #index", type: :controller do
  let!(:heading)   { Heading.new(attributes_for :heading, goods_nomenclature_item_id: "0101000000") }

  context 'heading is valid at given date', vcr: { cassette_name: "headings_changes#index" }  do
    before(:each) do
      get :index, heading_id: heading.short_code, format: :atom
    end

    it { should respond_with(:success) }
    it { expect(assigns(:changeable)).to be_present }
    it { expect(assigns(:changes)).to be_a(ChangesPresenter) }
  end

  context 'heading has no changes at given date', vcr: { cassette_name: "headings_changes#index_0101000000_1972-01-01" } do
    before(:each) do
      get :index, heading_id: heading.short_code, as_of: Date.new(1972,1,1), format: :atom
    end

    it { should respond_with(:success) }
    it { expect(assigns(:changeable)).to be_present }
    it { expect(assigns(:changes)).to be_a(ChangesPresenter) }

    it 'fetches no changes' do
      expect(assigns[:changes]).to be_empty
    end
  end

  context 'heading is not valid at given date', vcr: { cassette_name: "headings_changes#index_0101000000_1970-01-01" } do
    before(:each) do
      get :index, heading_id: heading.short_code, as_of: Date.new(1970,1,1), format: :atom
    end

    it { should respond_with(:not_found) }
  end
end
