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

  context "with blank match", vcr: { cassette_name: "search#blank_match" } do
    render_views

    let(:query) { "" }

    before(:each) do
      get :search, { q: query }
    end

    it { should respond_with(:success) }
    it { should assign_to(:search) }
    it 'assigns search attribute' do
      assigns[:search].q.should == query
    end
    it "should display no results" do
      response.body.should =~ /no results/
    end
  end
end
