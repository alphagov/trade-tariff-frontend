require 'api_entity'

class Commodity
  include ApiEntity

  attr_accessor :short_code, :code, :description, :substring, :hier_pos,
    :synonyms, :uk_vat_rate_cache, :third_country_duty_cache, :leaf

  has_one :section
  has_one :heading
  has_one :chapter
  has_many :ancestors, class_name: 'Commodity'

  def substring=(substring)
    @substring ||= substring.to_i
  end

  def self.find(id)
    new(get("/commodities/#{id}"))
  end

  def update_attrs(params)
    self.class.put("/commodities/#{to_param}", :query => params)
  end

  def leaf?
    leaf
  end

  def to_param
    code
  end

  def to_s
    description
  end

  def long_desc
    "#{code}: #{description}"
  end

  def import_measures
    Measure.all(commodity_id: self.to_param, type: :import_measures)
  end

  def export_measures
    Measure.all(commodity_id: self.to_param, type: :export_measures)
  end
end
