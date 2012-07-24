require 'api_entity'

class Heading
  include ApiEntity

  attr_accessor :description, :code, :commodities, :short_code,
                :import_measures, :export_measures, :has_measures,
                :declarative, :third_country_duty_rate, :uk_vat_rate,
                :synonyms

  has_one :chapter
  has_one :section
  has_many :commodities, class_name: 'Commodity'

  alias :declarative? :declarative

  def commodity_code
    code.first(10)
  end

  def display_short_code
    code[2..3]
  end

  def to_param
    short_code
  end

  def to_s
    description
  end
end
