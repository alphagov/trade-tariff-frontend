require 'spec_helper'

describe Region do
  describe "#country_names" do
    let(:country1) { attributes_for :country }
    let(:country2) { attributes_for :country }
    let(:region) { Region.new(attributes_for :region, type: 'CountryGroup', countries: [country1, country2]) }

    it 'returns country names joined by comma' do
      region.country_names.should == "#{country1[:name]}, #{country2[:name]}"
    end
  end

  describe "#country_group?" do
    let(:country_group) { Region.new(attributes_for :region, type: 'CountryGroup') }
    let(:country) { Region.new(attributes_for :region, type: 'Country') }

    it 'returns true if region is a country group and false otherwise' do
      country_group.country_group?.should be_true
      country.country_group?.should be_false
    end
  end

  describe "#to_s" do
    let(:region) { Region.new(attributes_for :region) }

    it 'returns region name' do
      region.to_s.should == region.name
    end
  end

  describe "#blank?" do
    let(:region_with_name) { Region.new(attributes_for :region) }
    let(:region_without_name) { Region.new(attributes_for :region, name: nil) }

    it 'retruns true if region name is not present and false otherwise' do
      region_with_name.blank?.should be_false
      region_without_name.blank?.should be_true
    end
  end
end
