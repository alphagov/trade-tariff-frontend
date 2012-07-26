require 'api_entity'

class Measure
  include ApiEntity

  attr_accessor :origin, :measure_type_description

  has_one :geographical_area
  has_one :legal_act
  has_one :additional_code
  has_many :excluded_countries, class_name: 'GeographicalArea'
  has_many :measure_components
  has_many :measure_conditions
  has_many :footnotes

  delegate :type, :description, to: :geographical_area, prefix: true

  def id
    @id ||= SecureRandom.hex(16)
  end

  def duty_expression
    measure_components.map(&:duty_expression).join(" ")
  end

  def condition_list
    measure_conditions.map(&:document_code).join(",")
  end

  def excluded_country_list
    excluded_countries.map(&:description).join(", ")
  end

  def third_country
    geographical_area.description == "ERGA OMNES"
  end

  def for_specific_countries
    geographical_area.description != "ERGA OMNES"
  end

  def is_first_measure_condition?(condition)
    measure_conditions.map(&:requirement)
    # measure_conditions.map(&:requirement).min(&:sequence_number) == condition.requirement['sequence_number']
  end

  def is_last_measure_condition?(condition)
    # measure_conditions.map(&:requirement).max(&:sequence_number) == condition.requirement['sequence_number']
  end
end
