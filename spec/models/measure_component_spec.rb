require 'spec_helper'

describe MeasureComponent do
  describe '#duty_expression' do
    context 'with measurement unit qualifier' do
      let(:measure_component) {
        MeasureComponent.new(
          duty_amount: 0.4,
          duty_expression_id: "01",
          duty_expression_description: "% (Amount)",
          duty_expression_abbreviation: "%",
          monetary_unit: "EUR",
          monetary_unit_abbreviation: nil,
          measurement_unit: "Hectokilogram",
          measurement_unit_qualifier: "Per 1|% by weight of sucrose"
        )
      }

      it 'correctly formats duty expression' do
        measure_component.duty_expression.should eq '0.40 EUR / (Hectokilogram/Per 1% by weight of sucrose)'
      end
    end
  end
end
