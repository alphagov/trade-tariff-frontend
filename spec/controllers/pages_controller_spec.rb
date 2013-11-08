require 'spec_helper'

describe PagesController, "GET to #opensearch" do
  context 'when asked for XML file' do
    render_views

    before(:each) do
      get :opensearch, format: 'xml'
    end

    it { should respond_with(:success) }
    it 'renders OpenSearch file successfully' do
      expect(response.body).to include 'Tariff'
    end
  end

  context 'when asked with no format' do
    before {
      get :opensearch
    }

    it 'returns HTTP 406 (not supported) status' do
      expect(response.status).to eq 406
    end
  end

  context 'with unsupported format' do
    before {
      get :opensearch, format: 'json'
    }

    it 'returns HTTP 406 (not supported) status' do
      expect(response.status).to eq 406
    end
  end
end
