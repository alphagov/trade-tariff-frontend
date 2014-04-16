require 'spec_helper'

describe SectionsController, "GET to #index", vcr: { cassette_name: "sections#index" }  do
  include CrawlerCommons

  context "non historical" do
    before { get :index }

    it { should respond_with(:success) }
    it { should assign_to(:sections) }
    it { should_not_include_robots_tag! }
  end

  context "historical request" do
    before {
      VCR.use_cassette "sections#historical_index" do
        historical_request :index
      end
    }
    it { should_include_robots_tag! }
  end
end

describe SectionsController, "GET to #show" do
  include CrawlerCommons

  context 'with existing section id provided', vcr: { cassette_name: "sections#show" } do
    let!(:section) { build :section }

    context "non historical" do
      before { get :show, id: section.position }

      it { should respond_with(:success) }
      it { should assign_to(:section) }
      it { should assign_to(:chapters) }
      it { should_not_include_robots_tag! }
    end

    context "historical" do
      before {
        VCR.use_cassette "sections#historical_show" do
          historical_request(:show, id: section.position)
        end
      }
      it { should_include_robots_tag! }
    end
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
