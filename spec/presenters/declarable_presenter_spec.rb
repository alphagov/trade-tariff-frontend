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

  describe "#national_vat_import_measures" do
    let(:eu_measure)           { attributes_for(:measure, origin: 'eu') }
    let(:national_measure_vat) { attributes_for(:measure, origin: 'uk',
                                                          measure_type_description: 'VAT') }
    let(:national_measure_pr)  { attributes_for(:measure, origin: 'uk',
                                                          measure_type_description: 'Prohibition or Restriction') }
    let(:export_measure)       { attributes_for(:measure) }
    let(:commodity)            { Commodity.new(attributes_for(:commodity, import_measures: [eu_measure,
                                                                                            national_measure_vat,
                                                                                            national_measure_pr],
                                                                          export_measures: [export_measure])) }

    subject { DeclarablePresenter.new(commodity) }

    it 'returns national import measures for VAT' do
      subject.national_vat_import_measures.should have_attribute_superset_of national_measure_vat
    end

    it 'returns measures wrapped with MeasurePresenter' do
      subject.national_vat_import_measures.first.should be_kind_of MeasurePresenter
    end

    it 'does not return export measure' do
      subject.national_vat_import_measures.should_not include export_measure
    end

    it 'does not return EU measure' do
      subject.national_vat_import_measures.should_not include eu_measure
    end

    it 'does not return national import measure for Prohibition or Restriction' do
      subject.national_vat_import_measures.should_not include national_measure_pr
    end
  end

  describe '#import_measures_for_third_country' do
    let(:measure_third_country)     { attributes_for(:measure, :third_country, origin: 'eu',) }
    let(:measure_specific_country)  { attributes_for(:measure, :specific_country, origin: 'eu') }
    let(:export_measure)       { attributes_for(:measure) }
    let(:commodity)            { Commodity.new(attributes_for(:commodity, import_measures: [measure_third_country,
                                                                                            measure_specific_country],
                                                                          export_measures: [export_measure])) }

    subject { DeclarablePresenter.new(commodity) }

    it 'returns import measures for third country' do
      subject.import_measures_for_third_country.should have_attribute_superset_of measure_third_country
    end

    it 'returns measures wrapped with MeasurePresenter' do
      subject.import_measures_for_third_country.first.should be_kind_of MeasurePresenter
    end

    it 'should not include export measures' do
      subject.import_measures_for_third_country.should_not have_attribute_superset_of export_measure
    end

    it 'does not return measures for specific countries' do
      subject.import_measures_for_third_country.should_not have_attribute_superset_of measure_specific_country
    end
  end

  describe "#import_measures_for_specific_countries" do
    let(:geographical_area)               { attributes_for(:geographical_area, geographical_area_id: nil) }
    let(:measure_third_country)           { attributes_for(:measure, :third_country, origin: 'eu',) }
    let(:measure_specific_country)        { attributes_for(:measure, :specific_country, origin: 'eu') }
    let(:measure_specific_country_group)  { attributes_for(:measure, geographical_area: geographical_area) }
    let(:export_measure)       { attributes_for(:measure) }
    let(:commodity)            { Commodity.new(attributes_for(:commodity, import_measures: [measure_third_country,
                                                                                            measure_specific_country,
                                                                                            measure_specific_country_group],
                                                                          export_measures: [export_measure])) }

    subject { DeclarablePresenter.new(commodity) }

    it 'returns import measures for specific countries' do
      subject.import_measures_for_specific_countries.should have_attribute_superset_of measure_specific_country
    end

    it 'returns measures wrapped with MeasurePresenter' do
      subject.import_measures_for_specific_countries.first.should be_kind_of MeasurePresenter
    end

    it 'should not include export measures' do
      subject.import_measures_for_specific_countries.should_not have_attribute_superset_of export_measure
    end

    it 'does not return measures for third countries' do
      subject.import_measures_for_specific_countries.should_not have_attribute_superset_of measure_third_country
    end
  end

  describe "#has_import_measures_for_specific_countries?" do
    let(:import_measure)        { attributes_for(:measure, :specific_country) }
    let(:commodity1)            { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity, import_measures: [import_measure]))) }
    let(:commodity2)            { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity))) }


    it 'returns true if declarable has any import measures for specific countries' do
      commodity1.has_import_measures_for_specific_countries?.should be_true
    end

    it 'returns false if declarable has any export measures for specific countries' do
      commodity2.has_import_measures_for_specific_countries?.should be_false
    end
  end

  describe "#has_export_measures_for_third_countries?" do
    let(:export_measure)        { attributes_for(:measure, :third_country) }
    let(:commodity1)            { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity, export_measures: [export_measure]))) }
    let(:commodity2)            { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity))) }


    it 'returns true if declarable has any export measures for third countries' do
      commodity1.has_export_measures_for_third_countries?.should be_true
    end

    it 'returns false if declarable has no export measures for third countries' do
      commodity2.has_export_measures_for_third_countries?.should be_false
    end
  end

  describe '#export_measures_for_third_countries' do
    let(:measure_third_country)     { attributes_for(:measure, :third_country,    origin: 'eu',) }
    let(:measure_specific_country)  { attributes_for(:measure, :specific_country, origin: 'eu') }
    let(:import_measure)       { attributes_for(:measure) }
    let(:commodity)            { Commodity.new(attributes_for(:commodity, export_measures: [measure_third_country,
                                                                                            measure_specific_country],
                                                                          import_measures: [import_measure])) }

    subject { DeclarablePresenter.new(commodity) }

    it 'returns export measures for third country' do
      subject.export_measures_for_third_country.should have_attribute_superset_of measure_third_country
    end

    it 'returns measures wrapped with MeasurePresenter' do
      subject.export_measures_for_third_country.first.should be_kind_of MeasurePresenter
    end

    it 'should not include import measures' do
      subject.export_measures_for_third_country.should_not have_attribute_superset_of import_measure
    end

    it 'does not return measures for specific countries' do
      subject.export_measures_for_third_country.should_not have_attribute_superset_of measure_specific_country
    end
  end

  describe "#has_vat_or_excise_third_country_export_measures?" do
    let(:export_measure)        { attributes_for(:measure, :third_country, :vat) }
    let(:commodity1)            { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity, export_measures: [export_measure]))) }
    let(:commodity2)            { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity))) }


    it 'returns true if declarable has any vat or excise third country export measures' do
      commodity1.has_vat_or_excise_third_country_export_measures?.should be_true
    end

    it 'returns false if declarable has any vat or excise third country export measures' do
      commodity2.has_vat_or_excise_third_country_export_measures?.should be_false
    end
  end

  describe "#has_export_measures_for_specific_countries?" do
    let(:export_measure)        { attributes_for(:measure, :specific_country) }
    let(:commodity1)            { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity, export_measures: [export_measure]))) }
    let(:commodity2)            { DeclarablePresenter.new(Commodity.new(attributes_for(:commodity))) }


    it 'returns true if declarable has any export measures for specific country' do
      commodity1.has_export_measures_for_specific_countries?.should be_true
    end

    it 'returns false if declarable has no export measures for specific country' do
      commodity2.has_export_measures_for_specific_countries?.should be_false
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
