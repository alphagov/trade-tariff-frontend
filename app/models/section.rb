class Section < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :chapters

  def to_s
    title
  end

  tire do
    mapping do
      indexes :id,           index: :not_analyzed
      indexes :title,        analyzer: 'snowball'
      indexes :position # in case we need to sort
    end
  end
end
