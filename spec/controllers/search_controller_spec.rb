require 'spec_helper'

describe SearchController, "POST to #search", vcr: { cassette_name: "search#search" }  do
  let(:query) { "horses" }

  before(:each) do
    get :search, { q: query }
  end

  it { should respond_with(:success) }
  it { should assign_to(:search) }
  it 'assigns search attribute' do
    assigns[:search].q.should == query
  end
end
