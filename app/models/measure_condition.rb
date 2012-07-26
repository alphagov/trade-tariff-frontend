require 'api_entity'

class MeasureCondition
  include ApiEntity

  attr_accessor :document_code, :action, :requirement, :condition, :measure_condition_components

  def duty_expression
    measure_condition_components.map{|mcc|
      DutyExpressionFormatter.format(mcc['duty_expression_id'], mcc['duty_amount'],
                                     mcc['monetary_unit'], mcc['measurement_unit'],
                                     mcc['measurement_unit_qualifier'])
    }.join(" ")
  end
end
