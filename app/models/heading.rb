require 'api_entity'
require 'formatter'
require 'declarable'

class Heading
  include Models::Declarable

  has_many :commodities, class_name: 'Commodity'
  has_many :children, class_name: 'Heading'

  attr_accessor :leaf, :declarable

  delegate :code, to: :chapter, prefix: true

  alias :leaf? :leaf
  alias :declarable? :declarable

  def eql?(other_heading)
    self.goods_nomenclature_item_id == other_heading.goods_nomenclature_item_id
  end

  def ==(other_heading)
    self.goods_nomenclature_item_id == other_heading.goods_nomenclature_item_id
  end

  def hash
    goods_nomenclature_item_id.to_i
  end

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
    formatted_description
  end

  def heading
    self
  end

  def display_meursing_table?
    !(([import_measures.map(&:measure_components).flatten.map(&:duty_expression_id) + export_measures.map(&:measure_components).flatten.map(&:duty_expression_id)]).flatten & ["12", "14", "21", "25", "27", "29"]).empty?
  end

  def footnotes
    [import_measures.map(&:footnotes).select(&:present?) + export_measures.map(&:footnotes).select(&:present?)].flatten
  end

  def third_country_duty
    @third_country_duty ||= basic_duty_rate_components.map(&:duty_expression)
  end

  def third_country_duty_rate
    (third_country_duty.blank?) ? "variable" : third_country_duty.join(" + ")
  end
end
