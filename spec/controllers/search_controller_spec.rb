require 'spec_helper'

describe SearchController, "GET to #show" do
  before(:each) do
    get :show
  end

  it { should respond_with(:success) }
  it { should assign_to(:search) }
end

describe SearchController, "POST to #search" do
  let(:attribute) { Search::ATTRIBUTES.sample }

  before(:each) do
    post :show, { search: Hash[attribute, "test"] }
  end

  it { should respond_with(:success) }
  it { should assign_to(:search) }
  it 'assigns search attribute' do
    assigns[:search].send(attribute).should == "test"
  end
end
