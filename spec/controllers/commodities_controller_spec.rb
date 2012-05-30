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
