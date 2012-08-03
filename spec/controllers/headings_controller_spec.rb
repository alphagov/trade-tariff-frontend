require 'spec_helper'

describe HeadingsController, "GET to #show", vcr: { cassette_name: "headings#show" } do
  let!(:heading)     { Heading.new(attributes_for :heading) }

  before(:each) do
    get :show, id: heading.to_param
  end

  it { should respond_with(:success) }
  it { should assign_to(:heading) }
  it { should assign_to(:commodities) }
end
