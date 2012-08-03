require 'spec_helper'

describe Commodity do
  describe "#leaf?" do
    let(:commodity_non_leaf) { Commodity.new(attributes_for :commodity, :with_children) }
    let(:commodity_leaf) { Commodity.new(attributes_for :commodity, :without_children) }

    it 'returns true if it is a left and false otherwise' do
      commodity_non_leaf.leaf?.should be_false
      commodity_leaf.leaf?.should be_true
    end
  end

  describe "#to_param" do
    let(:commodity) { Commodity.new(attributes_for :commodity) }

    it 'returns commodity code as param' do
      commodity.to_param.should == commodity.code
    end
  end
end
