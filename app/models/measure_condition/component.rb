require 'api_entity'

class MeasureCondition
  class Component
    include ApiEntity

    attr_accessor :duty_expression_id, :duty_amount, :monetary_unit,
                  :measurement_unit, :measurement_unit_qualifier
  end
end
