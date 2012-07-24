require 'spec_helper'

describe CommoditiesController, "GET to #show", :webmock do
  let!(:commodity) { attributes_for :commodity }

  before(:each) do
    stub_request(:get, "http://www.example.com/api/commodities/#{commodity[:short_code]}").
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/commodities_show.json"),
                     headers: { content_type: 'application/json' })

    get :show, id: commodity[:short_code]
  end

  it { should respond_with(:success) }
  it { should assign_to(:section) }
  it { should assign_to(:chapter) }
  it { should assign_to(:heading) }
  it { should assign_to(:commodity) }
end

describe CommoditiesController, "GET to #edit", :webmock do
  let!(:commodity) { attributes_for :commodity }

  before(:each) do
    stub_request(:get, "http://www.example.com/api/commodities/#{commodity[:short_code]}").
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/commodities_show.json"),
                     headers: { content_type: 'application/json' })

    get :edit, id: commodity[:short_code]
  end

  it { should respond_with(:success) }
  it { should assign_to(:commodity) }
end

describe CommoditiesController, "PUT to #update", :webmock do
  let!(:commodity) { attributes_for :commodity }

  before(:each) do
    stub_request(:get, /http:\/\/www.example.com\/api\/commodities\//).
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/commodities_show.json"),
                     headers: { content_type: 'application/json' })

    stub_request(:put, /http:\/\/www.example.com\/api\/commodities/).
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/commodities_show.json"),
                     headers: { content_type: 'application/json' })

    put :update, id: commodity[:short_code]
  end

  it { should respond_with(:redirect) }
  it { should assign_to(:commodity) }

  it "makes request to fetch commodity data" do
    a_request(:get, /http:\/\/www.example.com\/api\/commodities\//).should have_been_made
  end

  it "makes request to update commodity data" do
    a_request(:put, /http:\/\/www.example.com\/api\/commodities\//).should have_been_made
  end
end
