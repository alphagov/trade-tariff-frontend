require 'api_entity'

class Section
  include ApiEntity

  collection_path "/sections"

  attr_accessor :numeral,
                :position,
                :title,
                :chapters,
                :section_note,
                :chapter_from,
                :chapter_to

  has_many :chapters

  def chapter_from=(chapter_from)
    @chapter_from = chapter_from.to_i
  end

  def chapter_to=(chapter_to)
    @chapter_to = chapter_to.to_i
  end

  def chapters_title
    if chapter_from == chapter_to
      chapter_from
    else
      "#{chapter_from} to #{chapter_to}"
    end
  end

  def to_param
    position.to_s
  end

  def to_s
    title
  end
end
