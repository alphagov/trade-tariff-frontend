require 'spec_helper'

describe GeographicalArea do
  describe '.all', vcr: { cassette_name: "geographical_areas#countries" }  do
    let(:countries) { GeographicalArea.countries }

    it 'fetches geographical areas that are countries from the API' do
      countries.should be_kind_of Array
      countries.should_not be_blank
    end

    it 'sorts countries by id' do
      countries.first.id.should be < countries.second.id
    end

    it 'removes excluded countries (United Kingdom)' do
      countries.detect { |c| c.id == 'GB' }.should be_blank
    end
  end
end
