require 'api_entity'
require 'formatter'

class Chapter
  include ApiEntity
  include Models::Formatter

  attr_accessor :description, :headings, :goods_nomenclature_item_id, :chapter_note

  has_one :section
  has_many :headings

  format :description, with: DescriptionFormatter,
                       using: [:description]

  alias :code :goods_nomenclature_item_id

  def to_s
    description.mb_chars.downcase.to_s.gsub(/^(.)/) { $1.capitalize }
  end

  def short_code
    code.first(2)
  end

  def to_param
    short_code
  end
end
