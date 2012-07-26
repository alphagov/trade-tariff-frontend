require 'api_entity'

class Heading
  include ApiEntity

  attr_accessor :description, :code, :commodities, :short_code,
                :import_measures, :export_measures,
                :declarable, :third_country_duty_rate, :uk_vat_rate,
                :synonyms

  has_one :chapter
  has_one :section
  has_many :commodities, class_name: 'Commodity'
  has_many :import_measures, class_name: 'Measure'
  has_many :export_measures, class_name: 'Measure'

  alias :declarable? :declarable

  def commodity_code
    code.first(10)
  end

  def display_short_code
    code[2..3]
  end

  def display_export_code
    code[0..-3]
  end

  def to_param
    short_code
  end

  def to_s
    DecriptionFormatter.format(description)
  end

  def heading
    self
  end

  def footnotes
    [import_measures.map(&:footnotes).select(&:present?) + export_measures.map(&:footnotes).select(&:present?)].flatten
  end
end
