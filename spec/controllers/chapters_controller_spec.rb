require 'spec_helper'

describe ChaptersController, "GET to #show", :webmock do
  let!(:section) { attributes_for :section }
  let!(:chapter) { attributes_for :chapter, section: section }

  before(:each) do
    stub_request(:get, "http://www.example.com/api/chapters/#{chapter[:id]}").
           to_return(status: 200,
                     body: File.read("spec/fixtures/responses/chapters_show.json"),
                     headers: { content_type: 'application/json' })

    get :show, id: chapter[:id]
  end

  it { should respond_with(:success) }
  it { should assign_to(:chapter) }
  it { should assign_to(:headings) }
end
