require 'spec_helper'

describe CommoditiesHelper do
  let!(:commodity1) { Commodity.new(attributes_for :commodity) }
  let!(:commodity2) { Commodity.new(attributes_for :commodity) }

  let(:commodities) { [commodity1, commodity2] }

  describe ".commodity_tree" do
  end
end
