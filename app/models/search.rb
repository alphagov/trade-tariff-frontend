require 'api_entity'

class Search
  include ApiEntity

  attr_accessor :t,       # search text query
                :as_of,   # search date
                :country, # search country
                :day,
                :month,
                :year,
                :date

  def perform
    response = self.class.post("/search", body: { t: t, as_of: as_of })

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

  def to_s; t; end
end
