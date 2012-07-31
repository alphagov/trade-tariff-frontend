require 'api_entity'
require 'formatter'

class MeasureCondition
  class Requirement
    include ApiEntity
    include Models::Formatter

    attr_accessor :sequence_number, :condition_amount, :monetary_unit,
                  :measurement_unit, :measurement_unit_qualifier, :requirement

    format :duty_expression, with: DutyExpressionFormatter,
                             using: ["01", :condition_amount,
                                    :monetary_unit, :measurement_unit,
                                    :measurement_unit_qualifier]

    def to_s
      requirement
    end
  end
end
