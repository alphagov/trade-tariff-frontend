require 'api_entity'

class MeasureCondition
  include ApiEntity
  include Models::Formatter

  has_one  :requirement, class: 'MeasureCondition::Requirement'
  has_many :components,  class: 'MeasureCondition::Component'

  attr_accessor :document_code, :action, :condition, :requirement_type

  delegate :sequence_number, to: :requirement

  def has_document_based_requirement?
    requirement.present? && requirement_type == "document"
  end

  def has_duty_expression_based_requirement?
    requirement.present? && requirement_type == "duty_expression"
  end

  def duty_expression
    components.map(&:duty_expression).join(" ")
  end
end
