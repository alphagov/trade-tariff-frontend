require 'api_entity'

class Measure
  include ApiEntity

  attr_accessor :id, :origin, :effective_start_date, :effective_end_date,
                :import, :vat, :excise

  DEFAULT_GEOGRAPHICAL_AREA_ID = "1011" #ERGA OMNES

  has_one :geographical_area
  has_one :legal_act
  has_one :measure_type
  has_one :suspension_legal_act, class_name: 'LegalAct'
  has_one :additional_code
  has_one :order_number
  has_one :duty_expression
  has_many :excluded_countries, class_name: 'GeographicalArea'
  has_many :measure_conditions
  has_many :footnotes

  def relevant_for_country?(country_code)
    return false if excluded_countries.map(&:geographical_area_id).include?(country_code)
    return true if geographical_area.id == DEFAULT_GEOGRAPHICAL_AREA_ID && national?
    return true if country_code.blank? || geographical_area.id == country_code

    geographical_area.children_geographical_areas.map(&:id).include?(country_code)
  end

  def excluded_country_list
    excluded_countries.map(&:description).join(", ").html_safe
  end

  def national?
    origin == 'uk'
  end

  def vat?
    vat
  end

  def import?
    import
  end

  def export?
    !import
  end

  def destination
    import? ? "import" : "export"
  end

  def effective_start_date=(date)
    @effective_start_date = Date.parse(date) if date.present?
  end

  def effective_end_date=(date)
    @effective_end_date = Date.parse(date) if date.present?
  end

  def additional_code
    @additional_code.presence || NullObject.new(code: '')
  end

  # _999 is the master additional code and should come first
  def additional_code_sort
    if additional_code && additional_code.to_s.include?("999")
      "A000"
    else
      additional_code.code.to_s
    end
  end

  def key
    "#{national? ? 0: 1 }#{vat? ? 0 : 1}#{ geographical_area.children_geographical_areas.any? ? 0 : 1 }#{ geographical_area.description }#{ additional_code_sort }"
  end
end
