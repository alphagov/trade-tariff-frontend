require 'spec_helper'

describe Commodities::ChangesController, "GET to #index", vcr: { cassette_name: "commodities_changes#index" }  do
  let!(:commodity)   { Commodity.new(attributes_for :commodity, goods_nomenclature_item_id: "0101210000") }

  before(:each) do
    get :index, commodity_id: commodity.short_code, format: :atom
  end

  it { should respond_with(:success) }
  it { should assign_to(:changeable) }
  it { should assign_to(:changes) }
end
