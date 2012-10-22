require 'api_entity'
require 'formatter'

class MeasureCondition
  class Requirement
    include ApiEntity
    include Models::Formatter

    attr_accessor :sequence_number, :duty_amount, :monetary_unit,
                  :measurement_unit, :measurement_unit_qualifier, :certificate,
                  :certificate_type


    format :formatted_measurement_unit_qualifier, with: DescriptionFormatter,
                                                  using: :measurement_unit_qualifier

    format :duty_expression, with: RequirementDutyExpressionFormatter,
                             using: [:duty_amount,
                                     :monetary_unit,
                                     :measurement_unit,
                                     :formatted_measurement_unit_qualifier]

    def to_s
      "#{certificate_type}: #{certificate}"
    end
  end
end
