require 'api_entity'

class Heading
  include ApiEntity

  attr_accessor :id, :description, :code, :commodities, :short_code

  has_one :chapter
  has_one :section
  has_many :commodities

  def self.find(id)
    new(get("/headings/#{to_param}"))
  end

  def to_param
    short_code
  end

  def to_s
    description
  end

  def long_desc
    "HEADING #{short_code} - #{description}"
  end
end
