require 'spec_helper'

describe Measure do
  describe ".all" do
    context "if looking for heading measures", :webmock do
      let(:params) { { heading_id: Forgery(:basic).number } }

      before {
        stub_request(:get, "http://www.example.com/api/headings/#{params[:heading_id]}/import").
               to_return(status: 200, body: '{"third_country_measures":[], "specific_measures": {}}',
                         headers: { content_type: 'application/json' })
      }

      # it 'returns headings measures of requested type' do
      #   Measure.all(params.merge(type: "import"))

      #   a_request(:get, "www.example.com/api/headings/#{params[:heading_id]}/import").should have_been_made
      # end
    end

    context "if looking for commodity measures", :webmock do
      let(:params) { { commodity_id: Forgery(:basic).number } }

      before {
        stub_request(:get, "http://www.example.com/api/commodities/#{params[:commodity_id]}/export").
               to_return(status: 200, body: '{"third_country_measures":[], "specific_measures": {}}',
                         headers: { content_type: 'application/json' })
      }

      # it 'returns commodity measures of requested type' do
      #   Measure.all(params.merge(type: "export"))

      #   a_request(:get, "www.example.com/api/commodities/#{params[:commodity_id]}/export").should have_been_made
      # end
    end
  end
end
