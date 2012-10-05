require 'spec_helper'

describe TariffDate do
  subject { TariffDate }

  describe '#date' do
    it 'returns parsed date if it was provided' do
      date = Date.today + 1.day

      subject.new(date).date.should == date
    end

    it 'returns today\'s date if no date was parsed' do
      subject.new(nil).date.should == Date.today
    end
  end

  describe '#date=' do
    it 'parses and sets correct date' do
      subject.new('2011-04-03').to_s.should == '2011-04-03'
      subject.new('04/03/2011').to_s.should == '2011-03-04'
    end

    it 'ignores incorrect date in param' do
      subject.new('2011').to_s.should == subject.new(nil).date.to_s(:dashed)
    end
  end
end
