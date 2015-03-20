require 'spec_helper'

describe HeadingCommodityPresenter do
  describe '#root_commodities' do
    let(:root_commodity) { OpenStruct.new(root: true) }
    let(:non_root_commodity) { OpenStruct.new(root: false) }
    let(:commodities) { [root_commodity, non_root_commodity] }

    it 'returns commodities that have root identication' do
      expect(
        HeadingCommodityPresenter.new(commodities).root_commodities
      ).to include root_commodity
    end

    it 'does not return commodity not marked as root' do
      expect(
        HeadingCommodityPresenter.new(commodities).root_commodities
      ).to_not include non_root_commodity
    end
  end
end
