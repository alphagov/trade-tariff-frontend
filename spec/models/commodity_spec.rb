require 'spec_helper'

describe Commodity do

  describe "parent/children relationships" do
    let(:associated_commodities) {
                                   {
                                    commodities: [attributes_for(:commodity, goods_nomenclature_sid: 1,
                                                                             parent_sid: nil),
                                                  attributes_for(:commodity, parent_sid: 1,
                                                                             goods_nomenclature_sid: 2)]
                                   }
                                 }
    let(:heading_attributes) { attributes_for(:heading).merge(associated_commodities) }
    let(:heading) { Heading.new(heading_attributes) }

    describe "#children" do
      it 'returns list of commodities children' do
        heading

        heading.commodities.first.children.should include heading.commodities.last
      end

      it 'returns empty array if commodity does not have children' do
        heading

        heading.commodities.last.children.should be_blank
      end
    end

    describe "#root" do
      it 'returns children that have no parent_sid set' do
        heading

        root_children = heading.commodities.select(&:root)
        root_children.should     include heading.commodities.first
        root_children.should_not include heading.commodities.last
      end
    end

    describe "#leaf?" do
      let(:commodity_non_leaf) { heading.commodities.first }
      let(:commodity_leaf)     { heading.commodities.last }

      it 'returns true if it is a left and false otherwise' do
        commodity_non_leaf.leaf?.should be_false
        commodity_leaf.leaf?.should be_true
      end
    end
  end

  describe "#to_param" do
    let(:commodity) { Commodity.new(attributes_for :commodity) }

    it 'returns commodity code as param' do
      commodity.to_param.should == commodity.code
    end
  end

  describe '#consigned?' do
    let(:consigned_commodity)           { Commodity.new(attributes_for :commodity, description: 'Consigned from Malaysia') }
    let(:consigned_downcase_commodity)  { Commodity.new(attributes_for :commodity, description: 'consigned from Malaysia') }
    let(:non_consigned_commodity)       { Commodity.new(attributes_for :commodity) }

    it 'returns true if description matches Consigned from pattern' do
      consigned_commodity.consigned?.should be_true
    end

    it 'returns true if description matches consigned from (downcased) pattern' do
      consigned_downcase_commodity.consigned?.should be_true
    end

    it 'returns false if description does not match consigned pattern' do
      non_consigned_commodity.consigned?.should be_false
    end
  end

  describe '#consigned_from' do
    let(:consigned_commodity)     { Commodity.new(attributes_for :commodity, description: 'Consigned from Malaysia') }
    let(:non_consigned_commodity) { Commodity.new(attributes_for :commodity) }

    it 'returns country name' do
      consigned_commodity.consigned_from.should eq 'Malaysia'
    end

    it 'returns blank value for non consigned commodity' do
      non_consigned_commodity.consigned_from.should be_blank
    end
  end

  describe 'third country duty rate fetch' do
    let(:measure1)      { attributes_for :measure, :third_country, measure_type_description: 'abc', measure_components: [duty_amount: "10", duty_expression_id: "1"], additional_code: { code: '123' } }
    let(:measure2)      { attributes_for :measure, :third_country, measure_type_description: 'def', measure_components: [duty_amount: "20", duty_expression_id: "1"], additional_code: { code: '456' } }
    let(:measure3)      { attributes_for :measure, measure_type_id: '911', measure_type_description: 'xyz', geographical_area:  attributes_for(:geographical_area) }
    let(:measures)      { [measure1, measure2, measure3] }
    let(:commodity)     { Commodity.new(attributes_for :commodity, import_measures: measures) }

    describe '#third_country_duty_measures' do
      it 'picks only commodities that qualify for third country duty' do
        commodity.third_country_duty_measures.map(&:measure_type_description).should include 'abc'
        commodity.third_country_duty_measures.map(&:measure_type_description).should include 'def'
      end

      it 'does not pick other measures' do
        commodity.third_country_duty_measures.map(&:measure_type_description).should_not include 'xyz'
      end
    end

    describe '#third_country_duty_rate' do
      it 'sorts commodities by additional code and picks the last one' do
        commodity.third_country_duty_rate.should eq '20.00 %'
      end
    end
  end
end
