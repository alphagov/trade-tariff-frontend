require 'spec_helper'

describe SearchController, "POST to #search" do
  context "with exact match query", vcr: { cassette_name: "search#search_exact" }  do
    let(:query) { "01" }

    before(:each) do
      get :search, { q: query }
    end

    it { should respond_with(:redirect) }
    it { should assign_to(:search) }
    it 'assigns search attribute' do
      assigns[:search].q.should == query
    end
  end

  context "with fuzzy match query", vcr: { cassette_name: "search#search_fuzzy" }  do
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
end
