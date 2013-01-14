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

  describe "#relevant_for_country?" do
    it 'returns true if geographical area code matches' do
      measure = Measure.new(attributes_for(:measure, geographical_area: {iso_code: 'br',
                                                                         description: 'Brazil'}))
      measure.relevant_for_country?('br').should eq true
      measure.relevant_for_country?('fr').should eq false
    end

    it 'returns true if geographical area (group) contains matching code' do
      measure = Measure.new(attributes_for(:measure, geographical_area: {iso_code: nil,
                                                                         description: 'European Union',
                                                                         children_geographical_areas: [
                                                                           {iso_code: 'lt', description: 'Lithuania'},
                                                                           {iso_code: 'fr', description: 'France'}
                                                                         ]}))
      measure.relevant_for_country?('lt').should eq true
      measure.relevant_for_country?('it').should eq false
    end

    it 'returns false if country code is among excluded countries for this measure' do
      measure = Measure.new(attributes_for(:measure, geographical_area: {iso_code: nil,
                                                                         description: 'European Union',
                                                                         children_geographical_areas: [
                                                                           {iso_code: 'lt', description: 'Lithuania'}
                                                                         ]},
                                                     excluded_countries: [
                                                                          {iso_code: 'lt', description: 'Lithuania'}
                                                                         ]))
      measure.relevant_for_country?('lt').should eq false
    end
  end
end
