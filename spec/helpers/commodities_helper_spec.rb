require 'spec_helper'

describe CommoditiesHelper do
  let!(:commodity1) { Commodity.new(attributes_for :commodity) }
  let!(:commodity2) { Commodity.new(attributes_for :commodity) }

  let(:commodities) { [commodity1, commodity2] }

  describe ".commodity_tree" do
    it 'returns commodities in a list with dashes' do
      tree_code = helper.commodity_tree(commodities)
      tree_code.should =~ /#{commodity1.to_s}/
      tree_code.should =~ /#{commodity2.to_s}/
      tree_code.should =~ /-/
      tree_code.should =~ /--/
    end
  end
end
