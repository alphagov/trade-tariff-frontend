require 'api_entity'

class Commodity
  include ApiEntity

  attr_accessor :short_code, :code, :description, :substring, :hier_pos, :synonyms, :id

  has_one :section
  has_one :heading
  has_one :chapter
  has_many :import_measures, class_name: 'Measure'
  has_many :export_measures, class_name: 'Measure'

  def substring=(substring)
    @substring ||= substring.to_i
  end

  def self.find(id)
    new(get("/commodities/#{to_param}"))
  end

  def update_attrs(params)
    self.class.put("/commodities/#{to_param}", :query => params)
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
