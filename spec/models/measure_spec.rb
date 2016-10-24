require 'spec_helper'

describe Measure do
  describe "#relevant_for_country?" do
    it 'returns true when no geographical area is specified' do
      measure = Measure.new(attributes_for(:measure, :eu, geographical_area: {id: 'br',
                                                                         description: 'Brazil'}))
      expect(
        measure.relevant_for_country?(nil)
      ).to eq true
    end

    it 'returns true if a national measure regardless of the geographical area' do
      measure = Measure.new(attributes_for(:measure, :national, geographical_area: {id: 'lt',
                                                                         description: 'Lithuania'}))
      expect(
        measure.relevant_for_country?('br')
      ).to eq true
    end

    it 'returns false if a national measure and it is an excluded country' do
      measure = Measure.new(attributes_for(:measure, :national, geographical_area: {id: 'lt',
                                                                         description: 'Lithuania'},
                                                                         excluded_countries: [
                                                                          {id: 'lt', description: 'Lithuania', geographical_area_id: 'lt'}
                                                                         ]))
      expect(
        measure.relevant_for_country?('lt')
      ).to eq false
    end

    it 'returns true if geographical area code matches' do
      measure = Measure.new(attributes_for(:measure, :eu, geographical_area: {id: 'br',
                                                                         description: 'Brazil'}))
      expect(
        measure.relevant_for_country?('br')
      ).to eq true
      expect(
        measure.relevant_for_country?('fr')
      ).to eq false
    end

    it 'returns true if geographical area (group) contains matching code' do
      measure = Measure.new(attributes_for(:measure, :eu, geographical_area: {id: nil,
                                                                         description: 'European Union',
                                                                         children_geographical_areas: [
                                                                           {id: 'lt', description: 'Lithuania'},
                                                                           {id: 'fr', description: 'France'}
                                                                         ]}))
      expect(
        measure.relevant_for_country?('lt')
      ).to eq true
      expect(
        measure.relevant_for_country?('it')
      ).to eq false
    end

    it 'returns false if country code is among excluded countries for this measure' do
      measure = Measure.new(attributes_for(:measure, :eu, geographical_area: {id: nil,
                                                                         description: 'European Union',
                                                                         children_geographical_areas: [
                                                                           {id: 'lt', description: 'Lithuania', geographical_area_id: 'lt'}
                                                                         ]},
                                                     excluded_countries: [
                                                                          {id: 'lt', description: 'Lithuania', geographical_area_id: 'lt'}
                                                                         ]))
      expect(
        measure.relevant_for_country?('lt')
      ).to eq false
    end
  end
end
