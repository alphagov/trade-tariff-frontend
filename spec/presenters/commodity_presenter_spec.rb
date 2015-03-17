require 'spec_helper'

describe CommodityPresenter do
  describe '#show_commodity_tree?' do
    it 'returns true because commodities have ancestors' do
      expect(
        CommodityPresenter.new(Commodity.new()).show_commodity_tree?
      ).to be_truthy
    end
  end
end
