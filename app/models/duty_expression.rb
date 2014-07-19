require 'api_entity'

class DutyExpression
  include ApiEntity

  attr_accessor :base, :formatted_base, :national_measurement_units

  def national_measurement_units
    attributes["national_measurement_units"] || []
  end

  def to_s
    if national_measurement_units.any?
      "#{base} (#{national_measurement_units.join(" - ")})"
    else
      base
    end
  end
end
