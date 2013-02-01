require 'api_entity'

class NationalMeasurementUnit
  include ApiEntity

  attr_accessor :measurement_unit_code, :description, :level

  def description
    attributes[:description].presence || ''
  end

  def present?
    measurement_unit_code.present?
  end

  def to_s
    description
  end
end
