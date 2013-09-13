require 'api_entity'
require 'formatter'
require 'changeable'

class Chapter
  include ApiEntity
  include Models::Changeable
  include Models::Formatter

  attr_accessor :description, :headings, :goods_nomenclature_item_id, :chapter_note

  has_one :section
  has_many :headings

  format :formatted_description, with: DescriptionFormatter,
                                 using: :description

  delegate :numeral, to: :section, prefix: true

  alias :code :goods_nomenclature_item_id

  def short_code
    code.first(2)
  end

  def to_param
    short_code
  end

  def to_s
    formatted_description.mb_chars.downcase.to_s.gsub(/^(.)/) { $1.capitalize }
  end
end
