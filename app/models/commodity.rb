require 'api_entity'
require 'formatter'

class Commodity
  include ApiEntity
  include Models::Formatter

  attr_accessor :description, :goods_nomenclature_item_id,
                :synonyms, :uk_vat_rate, :third_country_duty_rate,
                :leaf, :parents, :synonyms, :producline_suffix, :number_indents,
                :goods_nomenclature_sid, :parent_sid, :casted_by, :bti_url

  has_one :section
  has_one :heading
  has_one :chapter
  has_many :ancestors, class_name: 'Commodity'
  has_many :import_measures, class_name: 'Measure'
  has_many :export_measures, class_name: 'Measure'
  has_many :basic_duty_rate_components, class_name: 'MeasureComponent'

  format :description, with: DescriptionTrimFormatter,
                       using: [:description],
                       as: :description_plain
  format :description, with: DescriptionFormatter,
                       using: [:description]

  def substring=(substring)
    @substring ||= substring.to_i
  end

  alias :code       :goods_nomenclature_item_id
  alias :short_code :goods_nomenclature_item_id

  def leaf?
    children.none?
  end

  def display_short_code
    code[4..-1]
  end

  def display_export_code
    code[0..-3]
  end

  def chapter_code
    code[0..1]
  end

  def heading_code
    code[2..3]
  end

  def to_param
    code
  end

  def to_s
    description
  end

  def footnotes
    [import_measures.map(&:footnotes).select(&:present?) + export_measures.map(&:footnotes).select(&:present?)].flatten.uniq(&:code).sort_by(&:code)
  end

  def third_country_duty_rate
    duty_expressions = basic_duty_rate_components.map(&:duty_expression)

    (duty_expressions.blank?) ? "variable" : duty_expressions.join(" ")
  end

  def root
    parent_sid.blank?
  end

  def children
    if casted_by.present?
      casted_by.commodities.select{|c| c.parent_sid == goods_nomenclature_sid }
    else
      []
    end
  end
end
