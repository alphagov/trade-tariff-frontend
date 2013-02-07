require 'spec_helper'

describe DeclarablePresenter do
  it 'relays all undefined methods to presented declarable object' do
    DeclarablePresenter.new(Commodity.new(goods_nomenclature_item_id: "0102210000")).heading_code.should eq("02")
  end

  describe '#to_s' do
    it 'returns formatted description of the declarable' do
      DeclarablePresenter.new(Commodity.new(description: "| s |")).to_s.should eq("&nbsp; s &nbsp;")
    end
  end

  describe "#display_meursing_table?" do
    let(:meursing_component) { attributes_for :measure_component, :meursing }
    let(:meursing_measure)   { attributes_for(:measure, measure_components: [meursing_component])}
    let(:commodity1) { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity, import_measures: [meursing_measure]))) }
    let(:commodity2) { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity))) }

    it 'returns true if measure has export or import measure components with meursing duty expression id' do
      commodity1.display_meursing_table?.should be_true
    end

    it 'returns false if measure has no export or import measure components with meursing duty expression id' do
      commodity2.display_meursing_table?.should be_false
    end
  end

  describe 'third country duty rate fetch' do
    let(:measure1)      { attributes_for :measure, :third_country, measure_type_description: 'abc', measure_components: [duty_amount: "10", duty_expression_id: "1"], additional_code: { code: '123' } }
    let(:measure2)      { attributes_for :measure, :third_country, measure_type_description: 'def', measure_components: [duty_amount: "20", duty_expression_id: "1"], additional_code: { code: '456' } }
    let(:measure3)      { attributes_for :measure, measure_type_id: '911', measure_type_description: 'xyz', geographical_area:  attributes_for(:geographical_area) }
    let(:measures)      { [measure1, measure2, measure3] }
    let(:commodity)     { CommodityPresenter.new(Commodity.new(attributes_for :commodity, import_measures: measures)) }

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
