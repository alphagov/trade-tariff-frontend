require 'spec_helper'

describe DeclarablePresenter do
  it 'relays all undefined methods to presented declarable object' do
    DeclarablePresenter.new(Commodity.new(goods_nomenclature_item_id: "0102210000")).heading_code.should eq("02")
  end

  describe 'third country duty rate fetch' do
    let(:measure1)      { attributes_for :measure, :third_country, measure_type_description: 'abc', measure_components: [duty_amount: "10", duty_expression_id: "1"], additional_code: { code: '123' } }
    let(:measure2)      { attributes_for :measure, :third_country, measure_type_description: 'def', measure_components: [duty_amount: "20", duty_expression_id: "1"], additional_code: { code: '456' } }
    let(:measure3)      { attributes_for :measure, measure_type_id: '911', measure_type_description: 'xyz', geographical_area:  attributes_for(:geographical_area) }
    let(:measures)      { [measure1, measure2, measure3] }
    let(:commodity)     { CommodityPresenter.new(Commodity.new(attributes_for :commodity, import_measures: measures)) }

    describe '#third_country_duty_measures' do
      it 'picks only commodities that qualify for third country duty' do
        commodity.third_country_duty_measures.map(&:measure_type).map(&:description).should include 'abc'
        commodity.third_country_duty_measures.map(&:measure_type).map(&:description).should include 'def'
      end

      it 'does not pick other measures' do
        commodity.third_country_duty_measures.map(&:measure_type).map(&:description).should_not include 'xyz'
      end
    end
  end
end
