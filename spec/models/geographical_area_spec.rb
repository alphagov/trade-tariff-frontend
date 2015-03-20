require 'spec_helper'

describe GeographicalArea do
  describe '.all', vcr: { cassette_name: "geographical_areas#countries" }  do
    let(:countries) { GeographicalArea.countries }

    it 'fetches geographical areas that are countries from the API' do
      expect(countries).to be_kind_of Array
      expect(countries).to_not be_blank
    end

    it 'sorts countries by id' do
      expect(countries.first.id).to be < countries.second.id
    end

    it 'removes excluded countries (United Kingdom)' do
      expect(
        countries.detect { |c| c.id == 'GB' }
      ).to be_blank
    end
  end
end
