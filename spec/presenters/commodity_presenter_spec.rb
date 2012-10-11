require 'spec_helper'

describe CommodityPresenter do
  describe '#show_commodity_tree?' do
    it 'returns true because commodities have ancestors' do
      CommodityPresenter.new(Commodity.new()).show_commodity_tree?.should be_true
    end
  end
end
