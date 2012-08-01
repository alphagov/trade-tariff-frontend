require 'spec_helper'

describe SectionsController, "GET to #index", :webmock do
  let!(:section) { attributes_for :section }

  before(:each) do
    stub_request(:get, "http://www.example.com/api/sections").
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/sections_index.json"),
                     headers: { content_type: 'application/json' })

    get :index
  end

  it { should respond_with(:success) }
  it { should assign_to(:sections) }
end

describe SectionsController, "GET to #show", :webmock do
  let!(:section) { attributes_for :section }
  let!(:actual_date) { Date.today.to_s(:dashed) }

  before(:each) do
    stub_request(:get, "http://www.example.com/api/sections/#{section[:position]}?as_of=#{actual_date}").
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/sections_show.json"),
                     headers: { content_type: 'application/json' })

    get :show, id: section[:position]
  end

  it { should respond_with(:success) }
  it { should assign_to(:section) }
  it { should assign_to(:chapters) }
end
