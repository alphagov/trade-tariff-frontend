require 'spec_helper'

describe Measure do
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
