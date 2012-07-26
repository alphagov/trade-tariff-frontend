require 'api_entity'

class MeasureCondition
  class Requirement
    include ApiEntity

    attr_accessor :sequence_number, :condition_amount, :monetary_unit,
                  :measurement_unit, :measurement_unit_qualifier, :requirement

    def duty_expression
      DutyExpressionFormatter.format("01", condition_amount, monetary_unit,
                                     measurement_unit, measurement_unit_qualifier)
    end

    def to_s
      requirement
    end
  end
end
