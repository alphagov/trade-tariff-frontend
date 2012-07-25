require 'api_entity'

class MeasureCondition
  include ApiEntity

  attr_accessor :document_code, :action, :requirement, :condition, :duty_expression
end
