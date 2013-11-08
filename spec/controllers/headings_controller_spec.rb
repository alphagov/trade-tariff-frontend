require 'spec_helper'

describe HeadingsController, "GET to #show" do
  context 'with existing heading id provided', vcr: { cassette_name: "headings#show" } do
    let!(:heading)     { Heading.new(attributes_for :heading) }

    before(:each) do
      get :show, id: heading.to_param
    end

    it { should respond_with(:success) }
    it { should assign_to(:heading) }
    it { should assign_to(:commodities) }
  end

  context 'with too long chapter id provided', vcr: { cassette_name: "headings#show_0101" } do
    let(:heading_id) { '010111' } # heading 0101 does exist

    before(:each) do
      get :show, id: heading_id
    end

    it 'redirects to heading page (strips exceeding heading id characters)' do
      expect(response.status).to eq 302
      expect(response.location).to eq heading_url(id: heading_id.first(4))
    end
  end

  context 'with non existing chapter id provided', vcr: { cassette_name: "headings#show_0110" } do
    let(:heading_id) { '0110' } # heading 0110 does not exist

    before(:each) do
      get :show, id: heading_id
    end

    it 'redirects to sections index page as fallback' do
      expect(response.status).to eq 302
      expect(response.location).to eq sections_url
    end
  end
end
