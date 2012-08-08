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
