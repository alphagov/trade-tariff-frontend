require 'api_entity'
require 'formatter'
require 'declarable'

class Commodity
  include Models::Declarable

  attr_accessor :parent_sid

  has_one :heading
  has_many :ancestors, class_name: 'Commodity'

  delegate :goods_nomenclature_item_id, :display_short_code, to: :heading, prefix: true
  alias :short_code :goods_nomenclature_item_id

  def substring=(substring)
    @substring ||= substring.to_i
  end

  def leaf?
    children.none?
  end

  def has_children?
    not(leaf?)
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
    formatted_description
  end

  def footnotes
    [import_measures.map(&:footnotes).select(&:present?) + export_measures.map(&:footnotes).select(&:present?)].flatten.uniq(&:code).sort_by(&:code)
  end

  def third_country_duty
    @third_country_duty ||= basic_duty_rate_components.map(&:duty_expression)
  end

  def third_country_duty_rate
    (third_country_duty.blank?) ? "variable" : third_country_duty.join(" + ")
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
