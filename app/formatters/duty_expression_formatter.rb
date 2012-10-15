class DutyExpressionFormatter

  def self.prettify(float)
    float.to_i == float ? float.to_i : float
  end

  def self.format(opts={})
    duty_expression_id = opts[:duty_expression_id]
    duty_expression_description = opts[:duty_expression_description]
    duty_expression_abbreviation = opts[:duty_expression_abbreviation]
    duty_amount = opts[:duty_amount]
    monetary_unit = opts[:monetary_unit]
    measurement_unit = opts[:measurement_unit]
    measurement_unit_qualifier = opts[:measurement_unit_qualifier]

    @formatted = ""

    case duty_expression_id
    when "99"
      @formatted << measurement_unit
    when "12", "14", "37", "40", "41", "42", "43", "44", "21", "25", "27", "29"
      if duty_expression_abbreviation.present?
        @formatted << duty_expression_abbreviation
      elsif duty_expression_description.present?
        @formatted << duty_expression_description
      end
    when "02", "04", "15", "17", "19", "20", "36"
      if duty_expression_abbreviation.present?
        @formatted << duty_expression_abbreviation
      elsif duty_expression_description.present?
        @formatted << duty_expression_description
      end
      if duty_amount.present?
        @formatted << " " << prettify(duty_amount).to_s
      end
      if monetary_unit.present?
        @formatted << " #{monetary_unit}"
      else
        @formatted << " %"
      end
      if measurement_unit.present? && measurement_unit_qualifier.present?
        @formatted << " / (#{measurement_unit}/#{measurement_unit_qualifier})"
      elsif measurement_unit.present?
        @formatted << " / #{measurement_unit}"
      end
    else
      if duty_amount.present?
        @formatted << prettify(duty_amount).to_s
      end
      if duty_expression_abbreviation.present? && !monetary_unit.present?
        @formatted << " " << duty_expression_abbreviation
      elsif duty_expression_description.present? && !monetary_unit.present?
        @formatted << " " << duty_expression_description
      elsif duty_expression_description.blank?
        @formatted << "%"
      end
      if monetary_unit.present?
        @formatted << " #{monetary_unit}"
      end
      if measurement_unit.present? && measurement_unit_qualifier.present?
        @formatted << " / (#{measurement_unit}/#{measurement_unit_qualifier})"
      elsif measurement_unit.present?
        @formatted << " / #{measurement_unit}"
      end
    end
    @formatted.html_safe
  end
end
