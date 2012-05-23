require 'spec_helper'

describe SearchController, "POST to #search", :webmock do
  let(:results) { stub(results: []) }

  before(:each) do
    stub_request(:post, "http://www.example.com/api/search").
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/search_search.json"),
                     headers: { content_type: 'application/json' })

    get :search, { q: "test" }
  end

  it { should respond_with(:success) }
  it { should assign_to(:search) }
  it 'assigns search attribute' do
    assigns[:search].q.should == "test"
  end
end
