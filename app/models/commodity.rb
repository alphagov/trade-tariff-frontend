require 'api_entity'

class Commodity
  include ApiEntity

  attr_accessor :id, :code, :description, :substring, :hier_pos, :synonyms

  has_one :section
  has_one :heading
  has_one :chapter
  has_many :import_measures, class_name: 'Measure'
  has_many :export_measures, class_name: 'Measure'

  def substring=(substring)
    @substring ||= substring.to_i
  end

  def self.find(id)
    new(get("/commodities/#{id}"))
  end

  def update_attrs(params)
    self.class.put("/commodities/#{id}", :query => params)
  end

  def short_code
    code.first(10)
  end

  def to_param
    short_code
  end

  def to_s
    description
  end

  def long_desc
    "#{code}: #{description}"
  end
end
