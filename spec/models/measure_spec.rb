require 'spec_helper'

describe Measure do
  describe "#relevant_for_country?" do
    it 'returns true if geographical area code matches' do
      measure = Measure.new(attributes_for(:measure, geographical_area: {id: 'br',
                                                                         description: 'Brazil'}))
      expect(
        measure.relevant_for_country?('br')
      ).to eq true
      expect(
        measure.relevant_for_country?('fr')
      ).to eq false
    end

    it 'returns true if geographical area (group) contains matching code' do
      measure = Measure.new(attributes_for(:measure, geographical_area: {id: nil,
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
      measure = Measure.new(attributes_for(:measure, geographical_area: {id: nil,
                                                                         description: 'European Union',
                                                                         children_geographical_areas: [
                                                                           {id: 'lt', description: 'Lithuania'}
                                                                         ]},
                                                     excluded_countries: [
                                                                          {id: 'lt', description: 'Lithuania'}
                                                                         ]))
      expect(
        measure.relevant_for_country?('lt')
      ).to eq false
    end
  end

  describe '#third_country' do
    let(:measure1) { Measure.new(attributes_for(:measure, geographical_area: {id: '1011' })) }
    let(:measure2) { Measure.new(attributes_for(:measure, geographical_area: {id: '103'  })) }

    it 'returns true if geographical area' do
      expect(measure1.third_country).to be true
    end

    it 'returns false if country name does not contain ERGA OMNES' do
      expect(measure2.third_country).to be false
    end
  end
end
