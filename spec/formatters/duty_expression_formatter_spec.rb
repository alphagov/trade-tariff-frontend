require 'spec_helper'
require 'duty_expression_formatter'

describe DutyExpressionFormatter do
  describe '.format' do
    let!(:opts){ Hash.new }
    context 'duty amount is preset' do
      it 'gets included into formatted result' do
        pending
        # opts[:duty_expression_id] = "01"
        # opts[:duty_amount] = 30
        # DutyExpressionFormatter.format(opts).should == "30.00"
      end
    end

    context 'duty expression description is present' do
      it 'gets included into formatted result' do
        pending
        # opts[:duty_expression_id] = "01"
        # opts[:duty_expression_description] = "test"
        # opts[:duty_amount] = 30
        # DutyExpressionFormatter.format(opts).should == "30.00 test"
      end
    end

    context 'monetary unit is present' do
      it 'gets included into formatted result' do
        pending
        # opts[:duty_expression_id] = "01"
        # opts[:duty_amount] = 30
        # opts[:duty_expression_description] = "test"
        # opts[:monetary_unit] = "EUR"
        # DutyExpressionFormatter.format(opts).should == "30.00 test EUR"
      end
    end

    context 'measurement unit is present' do
      it 'gets included into formatted result' do
        pending
        # opts[:duty_expression_id] = "01"
        # opts[:duty_amount] = 30
        # opts[:duty_expression_description] = "test"
        # opts[:monetary_unit] = "EUR"
        # opts[:measurement_unit] = "KG"
        # DutyExpressionFormatter.format(opts).should == "30.00 test EUR/KG"
      end
    end

    context 'measurement unit qualifier is present' do
      it 'gets included into formatted result' do
        pending
        # opts[:duty_expression_id] = "01"
        # opts[:duty_amount] = 30
        # opts[:duty_expression_description] = "test"
        # opts[:monetary_unit] = "EUR"
        # opts[:measurement_unit] = "KG"
        # opts[:measurement_unit_qualifier] = "L"
        # DutyExpressionFormatter.format(opts).should == "30.00 test EUR/KG L"
      end
    end
  end
end
