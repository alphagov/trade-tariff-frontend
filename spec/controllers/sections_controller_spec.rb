require 'spec_helper'

describe SectionsController, "GET to #index", vcr: { cassette_name: "sections#index" }  do
  before(:each) do
    get :index
  end

  it { should respond_with(:success) }
  it { should assign_to(:sections) }
end

describe SectionsController, "GET to #show" do
  context 'with existing section id provided', vcr: { cassette_name: "sections#show" } do
    let!(:section)    { build :section }

    before(:each) do
      get :show, id: section.position
    end

    it { should respond_with(:success) }
    it { should assign_to(:section) }
    it { should assign_to(:chapters) }
  end

  context 'with non existing section id provided', vcr: { cassette_name: "sections#show_9999" } do
    before(:each) do
      get :show, id: 9999
    end

    it 'redirect to sections index page as fallback' do
      expect(response.status).to eq 302
      expect(response.location).to eq sections_url
    end
  end
end
