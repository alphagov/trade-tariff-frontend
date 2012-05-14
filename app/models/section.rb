class Section
  include Tire::Model::Persistence

  property :section_number, analyzer: 'keyword'
  property :section_title, analyzer: 'snowball'
  property :chapters,       class: Chapter
end
