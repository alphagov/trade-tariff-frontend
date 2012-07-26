require 'api_entity'

class MeasureCondition
  include ApiEntity

  has_one  :requirement, class: 'MeasureConditionRequirement'
  has_many :components,  class: 'MeasureConditionComponent'

  attr_accessor :document_code, :action, :condition, :requirement_type

  def has_document_based_requirement?
    requirement.present? && requirement_type == "document"
  end

  def has_duty_expression_based_requirement?
    requirement.present? && requirement_type == "duty_expression"
  end

  def duty_expression
    components.map{|mcc|
      DutyExpressionFormatter.format(mcc.duty_expression_id, mcc.duty_amount,
                                     mcc.monetary_unit, mcc.measurement_unit,
                                     mcc.measurement_unit_qualifier)
    }.join(" ")
  end
end
