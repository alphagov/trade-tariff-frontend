require 'spec_helper'

describe SectionsController, "GET to #index", vcr: { cassette_name: "sections#index" }  do
  before(:each) do
    get :index
  end

  it { should respond_with(:success) }
  it { should assign_to(:sections) }
end

describe SectionsController, "GET to #show", vcr: { cassette_name: "sections#show" }  do
  let!(:section)    { build :section }

  before(:each) do
    get :show, id: section.position
  end

  it { should respond_with(:success) }
  it { should assign_to(:section) }
  it { should assign_to(:chapters) }
end
