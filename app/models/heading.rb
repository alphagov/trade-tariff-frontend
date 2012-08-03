require 'api_entity'
require 'formatter'

class Heading
  include ApiEntity
  include Models::Formatter

  attr_accessor :description, :commodities,
                :import_measures, :export_measures, :leaf,
                :declarable, :third_country_duty_rate, :uk_vat_rate,
                :synonyms, :goods_nomenclature_item_id

  has_one :chapter
  has_one :section
  has_many :commodities, class_name: 'Commodity'
  has_many :children, class_name: 'Heading'
  has_many :import_measures, class_name: 'Measure'
  has_many :export_measures, class_name: 'Measure'

  format :description, with: DescriptionFormatter,
                       using: [:description]

  delegate :code, to: :chapter, prefix: true

  alias :declarable? :declarable
  alias :leaf? :leaf
  alias :code :goods_nomenclature_item_id

  def commodity_code
    code.first(10)
  end

  def display_short_code
    code[2..3]
  end

  def display_export_code
    code[0..-3]
  end

  def short_code
    code.first(4)
  end

  def to_param
    short_code
  end

  def to_s
    description
  end

  def heading
    self
  end

  def footnotes
    [import_measures.map(&:footnotes).select(&:present?) + export_measures.map(&:footnotes).select(&:present?)].flatten
  end
end
