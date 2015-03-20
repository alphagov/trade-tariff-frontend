require 'spec_helper'

describe MeasurePresenter do
  describe "#geo_class" do
    context 'when geographical area is a country group' do
      let(:children_ga)       { [attributes_for(:geographical_area), attributes_for(:geographical_area)]}
      let(:geographical_area) { attributes_for(:geographical_area, geographical_area_id: nil, children_geographical_areas: children_ga) }
      let(:measure)           { Measure.new(attributes_for(:measure, geographical_area: geographical_area))}

      subject { MeasurePresenter.new(measure) }

      it 'returns list of contained children geographical area ids' do
        expect(subject.geo_class).to match /#{children_ga.first[:geographical_area_id]}/
        expect(subject.geo_class).to match /#{children_ga.last[:geographical_area_id]}/
      end
    end

    context 'when geographical area is a country' do
      let(:geographical_area) { attributes_for(:geographical_area) }
      let(:measure)           { Measure.new(attributes_for(:measure, geographical_area: geographical_area))}

      subject { MeasurePresenter.new(measure) }

      it 'returns geographical area id of geographical area' do
        expect(subject.geo_class).to match /#{geographical_area[:geographical_area_id]}/
      end
    end
  end

  describe "#has_children_geographical_areas?" do
    let(:children_ga)       { [attributes_for(:geographical_area), attributes_for(:geographical_area)]}
    let(:geographical_area) { attributes_for(:geographical_area, geographical_area_id: nil, children_geographical_areas: children_ga) }
    let(:measure1)          { MeasurePresenter.new(Measure.new(attributes_for(:measure, geographical_area: geographical_area))) }

    let(:measure2)          { MeasurePresenter.new(Measure.new(attributes_for(:measure, geographical_area: attributes_for(:geographical_area))))}

    it 'returns true if measures geographical area contains any children geographical area' do
      expect(measure1.has_children_geographical_areas?).to be true
    end

    it 'returns false if measures geographical area has no children geographical area' do
      expect(measure2.has_children_geographical_areas?).to be false
    end
  end

  describe "#children_geographical_areas" do
    let(:children_ga)       { [attributes_for(:geographical_area), attributes_for(:geographical_area)]}
    let(:geographical_area) { attributes_for(:geographical_area, geographical_area_id: nil, children_geographical_areas: children_ga) }
    let(:measure1)          { MeasurePresenter.new(Measure.new(attributes_for(:measure, geographical_area: geographical_area))) }

    it 'returns measure geographical area children geographical areas' do
      expect(measure1.children_geographical_areas).to have_attribute_superset_of children_ga.first
      expect(measure1.children_geographical_areas).to have_attribute_superset_of children_ga.last
    end
  end

  describe "#has_measure_conditions?" do
    let(:measure1)          { MeasurePresenter.new(Measure.new(attributes_for(:measure, :with_conditions))) }
    let(:measure2)          { MeasurePresenter.new(Measure.new(attributes_for(:measure))) }

    it 'returns true if measure has measure conditions' do
      expect(measure1.has_measure_conditions?).to be true
    end

    it 'returns false if measure has no measure conditions' do
      expect(measure2.has_measure_conditions?).to be false
    end
  end

  describe "#has_additional_code?" do
    let(:measure1)          { MeasurePresenter.new(Measure.new(attributes_for(:measure, :with_additional_code))) }
    let(:measure2)          { MeasurePresenter.new(Measure.new(attributes_for(:measure))) }

    it 'returns true if measure has additional code' do
      expect(measure1.has_additional_code?).to be true
    end

    it 'returns false if measure has no additional code' do
      expect(measure2.has_additional_code?).to be false
    end
  end

  describe "#has_references?" do
    let(:measure1)          { MeasurePresenter.new(Measure.new(attributes_for(:measure, :with_conditions))) }
    let(:measure2)          { MeasurePresenter.new(Measure.new(attributes_for(:measure, :with_footnotes))) }
    let(:measure3)          { MeasurePresenter.new(Measure.new(attributes_for(:measure))) }

    it 'returns true if measure has conditions' do
      expect(measure1.has_references?).to be true
    end

    it 'returns true if measure has footnotes' do
      expect(measure2.has_references?).to be true
    end

    it 'returns false if measure has no footnotes or conditions' do
      expect(measure3.has_references?).to be false
    end
  end
end
