class Section
  include Tire::Model::Persistence

  property :code, analyzer: 'keyword'
  property :title, analyzer: 'snowball'
end
