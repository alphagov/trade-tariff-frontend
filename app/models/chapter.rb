class Chapter
  include Tire::Model::Persistence

  property :section_number
  property :section_roman, analyzer: 'keyword'
  property :section_title, analyzer: 'snowball'
  property :chapter_number, analyzer: 'keyword'
  property :chapter_description, analyzer: 'snowball'
end
