class Chapter < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  has_many :commodities
  belongs_to :section

  tire do
    mapping do
      indexes :id,           index: :not_analyzed
      indexes :section_id,   index: :not_analyzed # not sure this will be needed yet
      indexes :number
      indexes :description,  analyzer: 'snowball'
    end
  end
end
