class Section
  include Tire::Model::Persistence

  property :number, analyzer: 'keyword'
  property :section, analyzer: 'snowball'
  property :chapters,       class: Chapter
end
