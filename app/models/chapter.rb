class Chapter
  include Tire::Model::Persistence

  property :number, analyzer: 'keyword'
  property :description, analyzer: 'snowball'

end
