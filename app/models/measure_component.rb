require 'api_entity'
require 'formatter'

class MeasureComponent
  include ApiEntity
  include Models::Formatter

  attr_accessor :duty_amount, :duty_expression_id, :duty_expression_description,
                :duty_expression_abbreviation, :monetary_unit, :measurement_unit, :measurement_unit_qualifier

  format :duty_expression, with: DutyExpressionFormatter,
                           using: [:duty_expression_id, :duty_expression_description, :duty_amount,
                                   :duty_expression_abbreviation, :monetary_unit, :measurement_unit,
                                   :measurement_unit_qualifier]
end
