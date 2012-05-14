class Commodity
  include Tire::Model::Persistence

  property :section_roman, analyzer: 'keyword'
  property :section_title, analyzer: 'snowball'
  property :chapter_number, analyzer: 'keyword'
  property :chapter_description, analyzer: 'snowball'
  property :commodity_description, analyzer: 'snowball'
  property :commodity_hier_pos
  property :commodity_substring
  property :commodity_code
end
