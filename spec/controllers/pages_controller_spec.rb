require 'spec_helper'

describe PagesController, "GET to #opensearch", type: :controller do
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
    it "raises ActionController::UnknownFormat as per rails 4" do
      expect {
        get :opensearch
      }.to raise_error(ActionController::UnknownFormat)
    end
  end

  context 'with unsupported format' do
    it "raises ActionController::UnknownFormat as per rails 4" do
      expect {
        get :opensearch, format: :json
      }.to raise_error(ActionController::UnknownFormat)
    end
  end
end
