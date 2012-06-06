require 'spec_helper'

describe Heading do
  describe "#to_param" do
    let(:heading) { Heading.new(attributes_for :heading) }

    it 'returns heading code as param' do
      heading.to_param.should == heading.short_code
    end
  end

  describe "#commodity_code" do
    let(:heading) { Heading.new(attributes_for :heading) }

    it 'returns first ten symbols of code' do
      heading.commodity_code.should == heading.code.to_s.first(10)
    end
  end
end
