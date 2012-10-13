require 'api_entity'
require 'formatter'

class MeasureCondition
  class Requirement
    include ApiEntity
    include Models::Formatter

    attr_accessor :sequence_number, :duty_amount, :monetary_unit,
                  :measurement_unit, :measurement_unit_qualifier, :certificate,
                  :certificate_type

    format :duty_expression, with: DutyExpressionFormatter,
                             using: [:duty_expression_id, :duty_expression_description,
                                     :duty_amount,
                                     :duty_expression_abbreviation,
                                     :monetary_unit, :measurement_unit,
                                     :measurement_unit_qualifier],
                             defaults: {
                                      duty_expression_id: '01'
                                    },
                             as: :duty_expression

    def to_s
      "#{certificate_type}: #{certificate}"
    end
  end
end
