require 'api_entity'

class Commodity
  include ApiEntity

  attr_accessor :id, :code, :description, :substring, :hier_pos

  has_one :section
  has_one :heading
  has_one :chapter

  def substring=(substring)
    @substring ||= substring.to_i
  end

  def self.find(id)
    new(get("/commodities/#{id}"))
  end

  def to_s
    description
  end

  def long_desc
    "#{code}: #{description}"
  end
end
