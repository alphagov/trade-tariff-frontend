class Heading < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :chapter
  has_many   :commodities

  def to_s
    "HEADING #{code.first(4)} - #{description}"
  end
end
