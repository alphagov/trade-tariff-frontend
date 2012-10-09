require 'duty_expression_formatter'

describe DutyExpressionFormatter do
  describe '.format' do
    let(:duty_amount) { 30 }
    let(:monetary_unit) { "EUR" }
    let(:measurement_unit) { "KG" }

    context 'duty_expression is 01' do
      let(:duty_expression) { "01" }

      context 'monetary unit and measurement unit present' do
        context 'monetary unit is EUC' do
          it 'returns duty amount with monetary and measurement units, EUC replaced' do
            DutyExpressionFormatter.format(duty_expression, duty_amount, "EUC", measurement_unit, nil).should == "30.00 EUR (EUC)/KG"
          end
        end

        context 'monetary unit is not EUC' do
          it 'returns duty amount with monetary and measurement units' do
            DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, nil).should == "30.00 EUR/KG"
          end
        end
      end

      context 'monetary unit or measurement unit missing' do
        it 'returns duty amount as %' do
          DutyExpressionFormatter.format(duty_expression, duty_amount, nil, nil, nil).should == "30.00%"
        end
      end
    end

    context 'duty_expression is 02' do
      let(:duty_expression) { "02" }

      it '- duty amount with monetary and measurement units' do
        DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, nil).should == "- 30.00 EUR/KG"
      end
    end

    context 'duty_expression is 03' do
      let(:duty_expression) { "03" }

      it '+ duty amount with monetary and measurement units' do
        DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, nil).should == "+ 30.00 EUR/KG"
      end
    end

    context 'duty_expression is 04' do
      let(:duty_expression) { "04" }

      it '+ duty amount with monetary and measurement units' do
        DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, nil).should == "+ 30.00 EUR/KG"
      end
    end

    context 'duty_expression is 12' do
      let(:duty_expression) { "12" }

      it 'EA' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "+ EA"
      end
    end

    context 'duty_expression is 14' do
      let(:duty_expression) { "14" }

      it 'EA R' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "+ EA R"
      end
    end

    context 'duty_expression is 15' do
      let(:duty_expression) { "15" }

      context 'measurement unit qualifier present' do
        let(:measurement_unit_qualifier) { "L" }

        it 'min amount with monetary, measurement and measurement unit qualifier' do
          DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, measurement_unit_qualifier).should == "min 30.00 EUR/(KG/L)"
        end
      end

      context 'measurement unit qualifier missing' do
        let(:measurement_unit_qualifier) { nil }

        it 'min amount with monetary, measurement units' do
          DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, measurement_unit_qualifier).should == "min 30.00 EUR/KG"
        end
      end
    end

    context 'duty_expression is 17' do
      let(:duty_expression) { "17" }

      it 'max amount %' do
        DutyExpressionFormatter.format(duty_expression, duty_amount, nil, nil, nil).should == "max 30.00%"
      end
    end

    context 'duty_expression is 19' do
      let(:duty_expression) { "19" }

      it 'returns + amount with monetary and measurement unit' do
        DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, nil).should == "+ 30.00 EUR/KG"
      end
    end

    context 'duty_expression is 20' do
      let(:duty_expression) { "20" }

      it 'returns + amount with monetary and measurement unit' do
        DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, nil).should == "+ 30.00 EUR/KG"
      end
    end

    context 'duty_expression is 21' do
      let(:duty_expression) { "21" }

      it 'returns AD S/Z' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "+ AD S/Z"
      end
    end

    context 'duty_expression is 25' do
      let(:duty_expression) { "25" }

      it 'returns AD S/Z R' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "+ AD S/Z R"
      end
    end

    context 'duty_expression is 27' do
      let(:duty_expression) { "27" }

      it 'returns AD FM' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "+ AD F/M"
      end
    end

    context 'duty_expression is 29' do
      let(:duty_expression) { "29" }

      it 'returns AD FM R' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "+ AD F/M R"
      end
    end

    context 'duty_expression is 35' do
      let(:duty_expression) { "35" }

      it 'returns max amount with monetary and measurement units' do
        DutyExpressionFormatter.format(duty_expression, duty_amount, monetary_unit, measurement_unit, nil).should == "max 30.00 EUR/KG"
      end
    end

    context 'duty_expression is 36' do
      let(:duty_expression) { "36" }

      it 'returns - amount with CIF' do
        DutyExpressionFormatter.format(duty_expression, duty_amount, nil, nil, nil).should == "- 30.00 % CIF"
      end
    end

    context 'duty_expression is 37' do
      let(:duty_expression) { "37" }

      it 'returns nil' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == nil
      end
    end

    context 'duty_expression is 40' do
      let(:duty_expression) { "40" }

      it 'returns Export refunds for cereals' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "Export refunds for cereals"
      end
    end

    context 'duty_expression is 41' do
      let(:duty_expression) { "41" }

      it 'returns Export refunds for rice' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "Export refunds for rice"
      end
    end

    context 'duty_expression is 42' do
      let(:duty_expression) { "42" }

      it 'returns Export refunds for eggs' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "Export refunds for eggs"
      end
    end

    context 'duty_expression is 43' do
      let(:duty_expression) { "43" }

      it 'returns Export refunds for sugar' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "Export refunds for sugar"
      end
    end

    context 'duty_expression is 44' do
      let(:duty_expression) { "44" }

      it 'returns Export refunds for milk products' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, nil, nil).should == "Export refunds for milk products"
      end
    end

    context 'duty_expression is 99' do
      let(:duty_expression) { "99" }

      it 'returns the measurement unit' do
        DutyExpressionFormatter.format(duty_expression, nil, nil, measurement_unit, nil).should == "KG"
      end
    end
  end
end
