require 'spec_helper'
require 'duty_expression_formatter'

describe DutyExpressionFormatter do
  describe '.format' do
    context 'duty amount is preset' do
      it 'gets included into formatted result' do
        DutyExpressionFormatter.format("01", nil, 30, nil, nil, nil).should == "30.00"
      end
    end

    context 'duty expression description is present' do
      it 'gets included into formatted result' do
        DutyExpressionFormatter.format("01", "test", 30, nil, nil, nil).should == "30.00 test"
      end
    end

    context 'monetary unit is present' do
      it 'gets included into formatted result' do
        DutyExpressionFormatter.format("01", "test", 30, "EUR", nil, nil).should == "30.00 test EUR"
      end
    end

    context 'measurement unit is present' do
      it 'gets included into formatted result' do
        DutyExpressionFormatter.format("01", "test", 30, "EUR", "KG", nil).should == "30.00 test EUR/KG"
      end
    end

    context 'measurement unit qualifier is present' do
      it 'gets included into formatted result' do
        DutyExpressionFormatter.format("01", "test", 30, "EUR", "KG", "L").should == "30.00 test EUR/KG L"
      end
    end
  end
end
