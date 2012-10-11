require 'api_entity'

class Measure
  include ApiEntity

  attr_accessor :origin, :measure_type_description, :ordernumber, :effective_start_date, :effective_end_date, :measure_type_id

  has_one :geographical_area
  has_one :legal_act
  has_one :suspension_legal_act, class_name: 'LegalAct'
  has_one :additional_code
  has_one  :order_number
  has_many :excluded_countries, class_name: 'GeographicalArea'
  has_many :measure_components
  has_many :measure_conditions
  has_many :footnotes

  delegate :type, :description, to: :geographical_area, prefix: true

  def id
    @id ||= SecureRandom.hex(16)
  end

  def effective_start_date=(date)
    @effective_start_date = Date.parse(date) if date.present?
  end

  def effective_end_date=(date)
    @effective_end_date = Date.parse(date) if date.present?
  end

  def duty_expression
    measure_components.map(&:duty_expression).join(" ").html_safe
  end

  def condition_list
    measure_conditions.map(&:document_code).join(",").html_safe
  end

  def excluded_country_list
    excluded_countries.map(&:description).join(", ").html_safe
  end

  def third_country
    geographical_area.description == "ERGA OMNES"
  end

  def for_specific_countries
    geographical_area.description != "ERGA OMNES"
  end


  def is_first_measure_condition?(condition)
    measure_conditions.select(&:has_duty_expression_based_requirement?)
                      .map(&:requirement)
                      .map(&:sequence_number)
                      .min  == condition.requirement.sequence_number
  end

  def is_last_measure_condition?(condition)
    measure_conditions.select(&:has_duty_expression_based_requirement?)
                      .map(&:requirement)
                      .map(&:sequence_number)
                      .max  == condition.requirement.sequence_number
  end

  def previous_condition_for(condition)
    measure_conditions.select(&:has_duty_expression_based_requirement?)
                      .detect{|mc| mc.requirement.sequence_number == condition.requirement.sequence_number - 1 }
  end

  def order_number
    @order_number.presence || OrderNumber.new(number: ordernumber, descriptionless: true)
  end

  # _999 is the master additional code and should come first
  def additional_code_sort
    if additional_code && additional_code.to_s.include?("999")
      "A000"
    else
      additional_code.to_s
    end
  end

  def sort_key
    "#{origin}#{geographical_area_description}#{additional_code_sort}#{measure_type_description}"
  end

  def third_country_duty
    measure_type_id == "103"
  end

  def national?
    origin == 'uk'
  end

  def vat?
    measure_type_description =~ /^VAT/
  end
end
