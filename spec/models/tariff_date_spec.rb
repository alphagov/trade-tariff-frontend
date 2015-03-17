require 'spec_helper'

describe TariffDate do
  subject { TariffDate }

  describe '#date' do
    it 'returns parsed date if it was provided' do
      date = Date.today + 1.day

      expect(subject.new(date).date).to eq date
    end

    it 'returns today\'s date if no date was parsed' do
      expect(subject.new(nil).date).to eq Date.today
    end
  end

  describe '#date=' do
    it 'parses and sets correct date' do
      expect(subject.new('2011-04-03').to_s).to eq '2011-04-03'
      expect(subject.new('04/03/2011').to_s).to eq '2011-03-04'
    end

    it 'ignores incorrect date in param' do
      expect(
        subject.new('2011').to_s
      ).to eq subject.new(nil).date.to_s(:dashed)
    end
  end
end
