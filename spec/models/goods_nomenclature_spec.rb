require 'spec_helper'

describe GoodsNomenclature do
  describe '#validity_start_date=' do
    let(:goods_nomenclature) { described_class.new }

    context 'passed date is present' do
      it 'sets date' do
        goods_nomenclature.validity_start_date = Date.today

        expect(goods_nomenclature.validity_start_date).to eq Date.today.to_date
      end
    end

    context 'passed date is blank' do
      it 'does not set validity end date' do
        goods_nomenclature.validity_start_date = nil

        expect(goods_nomenclature.validity_start_date).to be_blank
      end
    end
  end

  describe '#validity_end_date=' do
    let(:goods_nomenclature) { described_class.new }

    context 'passed date is present' do
      it 'sets date' do
        goods_nomenclature.validity_end_date = Date.today

        expect(goods_nomenclature.validity_end_date).to eq Date.today.to_date
      end
    end

    context 'passed date is blank' do
      it 'does not set validity end date' do
        goods_nomenclature.validity_end_date = nil

        expect(goods_nomenclature.validity_end_date).to be_blank
      end
    end
  end

  describe '#validity_start_date' do
    context 'the date is set' do
      let(:goods_nomenclature) {
        build(:goods_nomenclature, validity_start_date: Date.today)
      }

      it 'returns instance of Date' do
        expect(goods_nomenclature.validity_start_date).to be_kind_of Date
      end

      it 'returns parsed date' do
        expect(goods_nomenclature.validity_start_date).to eq Date.today.to_date
      end
    end

    context 'date is not set' do
      let(:goods_nomenclature) {
        build(:goods_nomenclature, validity_start_date: nil)
      }

      it 'returns NullObject' do
        expect(goods_nomenclature.validity_start_date).to be_kind_of NullObject
      end
    end
  end

  describe '#validity_end_date' do
    context 'the date is set' do
      let(:goods_nomenclature) {
        build(:goods_nomenclature, validity_end_date: Date.today)
      }

      it 'returns instance of Date' do
        expect(goods_nomenclature.validity_end_date).to be_kind_of Date
      end

      it 'returns parsed date' do
        expect(goods_nomenclature.validity_end_date).to eq Date.today.to_date
      end
    end

    context 'date is not set' do
      let(:goods_nomenclature) {
        build(:goods_nomenclature, validity_end_date: nil)
      }

      it 'returns NullObject' do
        expect(goods_nomenclature.validity_end_date).to be_kind_of NullObject
      end
    end
  end
end
