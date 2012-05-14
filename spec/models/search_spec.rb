require 'spec_helper'

describe Search do
  subject { Search }

  let(:search) { subject.new }

  it 'allows to read search attributes' do
    Search::ATTRIBUTES.each do |attribute|
      -> { search.send(attribute) }.should_not raise_error
    end
  end

  it 'allows to set search attributes directly' do
    Search::ATTRIBUTES.each do |attribute|
      -> { search.send("#{attribute}=", "test") }.should_not raise_error
    end
  end

  it 'is not a persisted model' do
    search.persisted?.should be_false
  end
end
