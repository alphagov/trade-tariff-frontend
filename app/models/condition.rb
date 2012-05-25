require 'api_entity'

class Condition
  include ApiEntity

  attr_accessor :id, :condition, :document_code, :requirement, :action, :duty_expression
end
