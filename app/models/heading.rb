require 'api_entity'

class Heading
  include ApiEntity

  attr_accessor :description, :code, :commodities, :short_code,
                :import_measures, :export_measures, :has_measures,
                :declarative, :third_country_duty_cache, :uk_vat_rate_cache

  has_one :chapter
  has_one :section
  has_many :commodities

  alias :declarative? :declarative

  def import_measures
    @import_measures ||= Measure.all(heading_id: self.to_param, type: :import_measures)
  end

  def export_measures
    @export_measures ||= Measure.all(heading_id: self.to_param, type: :export_measures)
  end

  def commodity_code
    code.first(10)
  end

  def to_param
    short_code
    # declarative? ? code : short_code
  end

  def to_s
    description
  end
end
