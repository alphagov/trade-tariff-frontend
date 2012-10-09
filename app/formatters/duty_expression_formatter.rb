class DutyExpressionFormatter
  def self.format(duty_expression_id, duty_expression_description, duty_amount, monetary_unit, measurement_unit, measurement_unit_qualifier)
    @formatted = ""
    if duty_amount.present?
      @formatted << sprintf("%.2f", duty_amount)
    end
    if duty_expression_description.present?
      @formatted << " " << duty_expression_description
    end
    if monetary_unit.present?
      @formatted << " " << monetary_unit
    end
    if measurement_unit.present?
      @formatted << "/" << measurement_unit
    end
    if measurement_unit_qualifier.present?
      @formatted << " " << measurement_unit_qualifier
    end
    @formatted
  end
end
