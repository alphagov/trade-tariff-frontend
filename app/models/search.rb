require 'api_entity'

class Search
  include ApiEntity

  attr_accessor :t,       # search text query
                :country, # search country
                :day,
                :month,
                :year

  def perform
    response = self.class.post("/search", body: { t: t, as_of: date.to_s(:db) })

    raise ApiEntity::Error if response.code == 500

    Outcome.new(response)
  end

  def q
    'trade_tariff'
  end

  def countries(geographical_area_klass = GeographicalArea)
    @countries ||= geographical_area_klass.countries.sort_by(&:description)
  end

  def date
    @date ||= TariffDate.parse(attributes.slice(*TariffDate::DATE_KEYS)).date
  end

  def contains_search_term?
    t.present?
  end

  def query_attributes
    attributes.slice(:day, :year, :month, :country)
  end

  def country
    countries.detect { |c| c.geographical_area_id == attributes['country'] }
  end

  def to_s
    t
  end
end
