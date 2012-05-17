class Heading < Commodity
  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :chapter
  has_many   :commodities, foreign_key: 'heading_id'

  def to_s
    "HEADING #{code.first(4)} - #{description}"
  end
end
