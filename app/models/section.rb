class Section < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  tire do
    mapping do
      indexes :id,           index: :not_analyzed
      indexes :title,        analyzer: 'snowball'
    end
  end
end
