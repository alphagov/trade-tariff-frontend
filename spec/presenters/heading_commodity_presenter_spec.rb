require 'spec_helper'

describe HeadingCommodityPresenter do
  describe '#root_commodities' do
    let(:root_commodity) { stub(root: true) }
    let(:non_root_commodity) { stub(root: false) }
    let(:commodities) { [root_commodity, non_root_commodity] }

    it 'returns commodities that have root identication' do
      HeadingCommodityPresenter.new(commodities).root_commodities.should include root_commodity
    end

    it 'does not return commodity not marked as root' do
      HeadingCommodityPresenter.new(commodities).root_commodities.should_not include non_root_commodity
    end
  end
end
