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

  # There are no consigned declarable headings
  def consigned?
    description =~ /Consigned from/i
  end

  def consigned_from
    description.match(/Consigned from (.*)/)[1] if consigned?
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

  def last_child?
    if casted_by.present?
      self.goods_nomenclature_sid == casted_by.commodities.select{|c| c.parent_sid == self.parent_sid }.last.goods_nomenclature_sid
    else
      false
    end
  end
end
