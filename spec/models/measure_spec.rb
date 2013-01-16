require 'spec_helper'

describe Measure do
  describe "#relevant_for_country?" do
    it 'returns true if geographical area code matches' do
      measure = Measure.new(attributes_for(:measure, geographical_area: {geographical_area_id: 'br',
                                                                         description: 'Brazil'}))
      measure.relevant_for_country?('br').should eq true
      measure.relevant_for_country?('fr').should eq false
    end

    it 'returns true if geographical area (group) contains matching code' do
      measure = Measure.new(attributes_for(:measure, geographical_area: {geographical_area_id: nil,
                                                                         description: 'European Union',
                                                                         children_geographical_areas: [
                                                                           {geographical_area_id: 'lt', description: 'Lithuania'},
                                                                           {geographical_area_id: 'fr', description: 'France'}
                                                                         ]}))
      measure.relevant_for_country?('lt').should eq true
      measure.relevant_for_country?('it').should eq false
    end

    it 'returns false if country code is among excluded countries for this measure' do
      measure = Measure.new(attributes_for(:measure, geographical_area: {geographical_area_id: nil,
                                                                         description: 'European Union',
                                                                         children_geographical_areas: [
                                                                           {geographical_area_id: 'lt', description: 'Lithuania'}
                                                                         ]},
                                                     excluded_countries: [
                                                                          {geographical_area_id: 'lt', description: 'Lithuania'}
                                                                         ]))
      measure.relevant_for_country?('lt').should eq false
    end
  end
end
