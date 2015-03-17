require 'spec_helper'

describe Heading do
  describe '#to_param' do
    let(:heading) { Heading.new(attributes_for :heading) }

    it 'returns heading code as param' do
      expect(heading.to_param).to eq heading.short_code
    end
  end

  describe '#commodity_code' do
    let(:heading) { Heading.new(attributes_for :heading) }

    it 'returns first ten symbols of code' do
      expect(heading.commodity_code).to eq heading.code.to_s.first(10)
    end
  end

  describe '#consigned?' do
    it 'returns false (there are no consigned declarable headings)' do
      expect(subject.consigned?).to be false
    end
  end
end
