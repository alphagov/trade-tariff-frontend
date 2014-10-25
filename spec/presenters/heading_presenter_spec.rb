require 'spec_helper'

describe HeadingPresenter do
  describe '#show_commodity_tree?' do
    it 'returns false because headings do not have ancestor commodities' do
      HeadingPresenter.new(Heading.new()).show_commodity_tree?.should be false
    end
  end
end
