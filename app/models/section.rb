require 'api_entity'

class Section
  include ApiEntity

  collection_path "/sections"

  attr_accessor :numeral, :position, :title, :chapters, :section_note

  has_many :chapters

  def to_param
    position
  end

  def title_without_chapters
    title.split(/\(.*\)/).first.strip
  end

  def title_chapters
    title.match(/\(.*\)/)[0]
  end

  def to_s
    title
  end
end
