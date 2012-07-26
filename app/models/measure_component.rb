require 'api_entity'

class MeasureComponent
  include ApiEntity

  attr_accessor :duty_amount, :duty_expression_id, :monetary_unit,
                :measurement_unit, :measurement_unit_qualifier

  def duty_expression
    DutyExpressionFormatter.format(duty_expression_id, duty_amount,
                                   monetary_unit, measurement_unit,
                                   measurement_unit_qualifier)
  end
end
