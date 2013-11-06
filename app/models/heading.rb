require 'api_entity'
require 'declarable'
require 'changeable'

class Heading
  include Models::Changeable
  include Models::Declarable

  has_many :commodities, class_name: 'Commodity'
  has_many :children, class_name: 'Heading'

  attr_accessor :leaf, :declarable

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
  alias :heading_display_short_code :display_short_code

  def display_export_code
    code[0..-3]
  end

  def short_code
    code.first(4)
  end

  # There are no consigned declarable headings
  def consigned?
    false
  end

  def to_param
    short_code
  end

  def footnotes
    [import_measures.map(&:footnotes).select(&:present?) + export_measures.map(&:footnotes).select(&:present?)].flatten
  end

  def to_s
    formatted_description || description
  end
end
