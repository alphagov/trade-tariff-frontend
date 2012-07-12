require 'api_entity'

class Commodity
  include ApiEntity

  attr_accessor :short_code, :code, :description, :substring, :hier_pos,
                :synonyms, :uk_vat_rate_cache, :third_country_duty_cache,
                :leaf, :parents, :synonyms, :display_short_code, :producline_suffix

  has_one :section
  has_one :heading
  has_one :chapter
  has_many :commodities, class_name: 'Commodity'
  has_many :ancestors, class_name: 'Commodity'

  def substring=(substring)
    @substring ||= substring.to_i
  end

  def update_attrs(params)
    self.class.put("/commodities/#{to_param}", body: params)
  end

  def leaf?
    # TODO: is this right?
    commodities.length == 0
  end

  def to_param
    "#{code}#{producline_suffix}"
  end

  def to_s
    description
  end

  def import_measures
    Measure.all(commodity_id: self.to_param, type: :import_measures)
  end

  def export_measures
    Measure.all(commodity_id: self.to_param, type: :export_measures)
  end
end
