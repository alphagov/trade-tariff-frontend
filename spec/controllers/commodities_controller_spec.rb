require 'spec_helper'

describe CommoditiesController, "GET to #show", vcr: { cassette_name: "commodities#show" } do
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

describe CommoditiesController, "GET to #edit", vcr: { cassette_name: "commodities#edit" } do
  let!(:commodity) { Commodity.new(attributes_for :commodity) }

  before(:each) do
    get :edit, id: commodity.short_code
  end

  it { should respond_with(:success) }
  it { should assign_to(:commodity) }
end

describe CommoditiesController, "PUT to #update", vcr: { cassette_name: "commodities#put" } do
  let!(:commodity)   { Commodity.new(attributes_for :commodity) }

  before(:each) do
    put :update, id: commodity.to_param
  end

  it { should respond_with(:redirect) }
  it { should assign_to(:commodity) }
end
