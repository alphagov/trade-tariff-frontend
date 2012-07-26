require 'api_entity'

class Commodity
  include ApiEntity

  attr_accessor :short_code, :code, :description, :substring, :hier_pos,
                :synonyms, :uk_vat_rate, :third_country_duty_rate,
                :leaf, :parents, :synonyms, :producline_suffix, :number_indents

  has_one :section
  has_one :heading
  has_one :chapter
  has_many :children, class_name: 'Commodity'
  has_many :ancestors, class_name: 'Commodity'
  has_many :import_measures, class_name: 'Measure'
  has_many :export_measures, class_name: 'Measure'

  def substring=(substring)
    @substring ||= substring.to_i
  end

  def update_attrs(params)
    self.class.put("/commodities/#{to_param}", body: params)
  end

  def leaf?
    children.none?
  end

  def display_short_code
    code[4..-1]
  end

  def display_export_code
    code[0..-3]
  end

  def to_param
    "#{code}#{producline_suffix}"
  end

  def to_s
    description
  end

  def footnotes
    [import_measures.map(&:footnotes).select(&:present?) + export_measures.map(&:footnotes).select(&:present?)].flatten
  end
end
