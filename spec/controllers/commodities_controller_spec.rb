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

describe CommoditiesController, "GET to #import_measures", :webmock do
  let!(:commodity) { attributes_for :commodity }

  before(:each) do
    stub_request(:get, /http:\/\/www.example.com\/api\/commodities\/\d+$/).
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/commodities_show.json"),
                     headers: { content_type: 'application/json' })

        stub_request(:get, /http:\/\/www.example.com\/api\/commodities\/\S+\/import_measures$/).
               to_return(status: 200, body: '{"third_country_measures":[], "specific_measures": {}}',
                         headers: { content_type: 'application/json' })

    get :import_measures, id: commodity[:short_code]
  end

  it { should respond_with(:success) }
  it { should assign_to(:measurable) }
  it { should assign_to(:import_measures) }
  it "makes request to fetch commodity data" do
    a_request(:get, /http:\/\/www.example.com\/api\/commodities\/\d+$/).should have_been_made
  end

  # it "makes request to fetch commodity import measures" do
  #   a_request(:get, /http:\/\/www.example.com\/api\/commodities\/\S+\/import_measures$/).should have_been_made
  # end
end

describe CommoditiesController, "GET to #export_measures", :webmock do
  let!(:commodity) { attributes_for :commodity }

  before(:each) do
    stub_request(:get, /http:\/\/www.example.com\/api\/commodities\/\d+$/).
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/commodities_show.json"),
                     headers: { content_type: 'application/json' })

        stub_request(:get, /http:\/\/www.example.com\/api\/commodities\/\S+\/export_measures$/).
               to_return(status: 200, body: '{"third_country_measures":[], "specific_measures": {}}',
                         headers: { content_type: 'application/json' })

    get :export_measures, id: commodity[:short_code]
  end

  it { should respond_with(:success) }
  it { should assign_to(:measurable) }
  it { should assign_to(:export_measures) }
  it "makes request to fetch commodity data" do
    a_request(:get, /http:\/\/www.example.com\/api\/commodities\/\d+$/).should have_been_made
  end

  # it "makes request to fetch commodity export measures" do
  #   a_request(:get, /http:\/\/www.example.com\/api\/commodities\/\S+\/export_measures$/).should have_been_made
  # end
end
