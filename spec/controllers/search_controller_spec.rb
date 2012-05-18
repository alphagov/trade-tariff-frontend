require 'spec_helper'

describe SearchController, "POST to #search" do
  let(:results) { stub(results: []) }

  before(:each) do
    Commodity.expects(:search).returns(results)

    post :search, { search: { q: "test" } }
  end

  it { should respond_with(:success) }
  it { should assign_to(:search) }
  it 'assigns search attribute' do
    assigns[:search].q.should == "test"
  end
end
