require 'spec_helper'

describe MeasureCollection do
  describe '#for_country' do
    let(:measure1) { Measure.new(attributes_for(:measure, geographical_area: { geographical_area_id: 'IT' })) }
    let(:measure2) { Measure.new(attributes_for(:measure, geographical_area: { geographical_area_id: 'RU' })) }
    let(:collection) { MeasureCollection.new([measure1, measure2]) }

    it 'filters measures by country code' do
      expect(
        collection.for_country('IT')
      ).to_not include measure2
    end
  end

  describe '#for_all_countries' do
    let(:measure1) { Measure.new(attributes_for(:measure, :third_country)) }
    let(:measure2) { Measure.new(attributes_for(:measure, :specific_country)) }
    let(:collection) { MeasureCollection.new([measure1, measure2]) }

    it 'filters measures belonging to third country group' do
      expect(collection.for_all_countries).to_not include measure2
    end
  end

  describe '#for_specific_countries' do
    let(:measure1) { Measure.new(attributes_for(:measure, :third_country)) }
    let(:measure2) { Measure.new(attributes_for(:measure, :specific_country)) }
    let(:collection) { MeasureCollection.new([measure1, measure2]) }

    it 'filters measures for specific countries' do
      expect(collection.for_specific_countries).to_not include measure1
    end
  end

  describe '#vat' do
    let(:measure1) { Measure.new(attributes_for(:measure, :vat)) }
    let(:measure2) { Measure.new(attributes_for(:measure)) }
    let(:collection) { MeasureCollection.new([measure1, measure2]) }

    it 'filters VAT measures' do
      expect(collection.vat).to_not include measure2
    end
  end

  describe '#national' do
    let(:measure1) { Measure.new(attributes_for(:measure, :national)) }
    let(:measure2) { Measure.new(attributes_for(:measure)) }
    let(:collection) { MeasureCollection.new([measure1, measure2]) }

    it 'filters national measures' do
      expect(collection.national).to_not include measure2
    end
  end

  describe '#except' do
    let(:measure1) { Measure.new(attributes_for(:measure, :third_country)) }
    let(:measure2) { Measure.new(attributes_for(:measure, :specific_country)) }
    let(:collection) { MeasureCollection.new([measure1, measure2]) }

    it 'removes matching measures' do
      expect(
        collection.except(:third_country)
      ).to_not include measure1
    end
  end

  describe '#to_a' do
    context 'presenter class given (default)' do
      let(:measure) { Measure.new(attributes_for(:measure)) }
      let(:collection) { MeasureCollection.new([measure]) }

      it 'returns an Array' do
        expect(collection.to_a).to be_kind_of Array
      end

      it 'returns array of Measures wrapped in Presenter objects' do
        expect(collection.to_a.first).to be_kind_of collection.presenter_klass
      end
    end

    context 'presenter class blank' do
      let(:measure) { Measure.new(attributes_for(:measure)) }
      let(:collection) { MeasureCollection.new([measure], nil) }

      it 'returns an Array' do
        expect(collection.to_a).to be_kind_of Array
      end

      it 'returns plain Measure object array' do
        expect(collection.to_a.first).to be_kind_of Measure
      end
    end
  end

  describe "#present?" do
    context 'measures present' do
      let(:measure) { Measure.new(attributes_for(:measure)) }
      subject { MeasureCollection.new([measure]) }

      it 'returns true' do
        expect(subject).to be_present
      end
    end

    context 'measures blank' do
      subject { MeasureCollection.new([]) }

      it 'returns false' do
        expect(subject).to_not be_present
      end
    end
  end
end
