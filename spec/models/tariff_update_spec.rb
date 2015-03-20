require 'spec_helper'

describe TariffUpdate do
  describe '#update_type' do
    context 'when Chief update' do
      let(:tariff_update) { TariffUpdate.new(attributes_for :tariff_update, :chief) }

      it 'returns Chief' do
        expect(tariff_update.update_type).to eq 'CHIEF'
      end
    end

    context 'when Taric update' do
      let(:tariff_update) { TariffUpdate.new(attributes_for :tariff_update, :taric) }

      it 'returns Taric' do
        expect(tariff_update.update_type).to eq 'TARIC'
      end
    end
  end

  describe '#updated_at' do
    let(:tariff_update) { TariffUpdate.new(attributes_for :tariff_update, :chief) }

    it 'returns instance of date' do
      expect(tariff_update.updated_at).to be_kind_of Date
    end
  end
end
