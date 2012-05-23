require 'api_entity'

class Heading
  include ApiEntity

  attr_accessor :id, :description, :code, :commodities

  has_one :chapter
  has_one :section
  has_many :commodities

  def self.find(id)
    new(get("/headings/#{id}"))
  end

  def short_code
    code.first(4)
  end

  def to_s
    "HEADING #{short_code} - #{description}"
  end
end
