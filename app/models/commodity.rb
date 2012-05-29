require 'api_entity'

class Commodity
  include ApiEntity

  attr_accessor :id, :code, :description, :substring, :hier_pos, :synonyms

  has_one :section
  has_one :heading
  has_one :chapter
  has_many :measures

  def substring=(substring)
    @substring ||= substring.to_i
  end

  def self.find(id)
    new(get("/commodities/#{id}"))
  end

  def update_attrs(params)
    self.class.put("/commodities/#{id}", :query => params)
  end

  def to_s
    description
  end

  def long_desc
    "#{code}: #{description}"
  end
end
