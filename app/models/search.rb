require 'api_entity'

class Search
  include ApiEntity

  attr_accessor :t,       # search text query
                :country, # search country
                :day,
                :month,
                :year,
                :as_of    # legacy format for specifying date

  def perform
    response = self.class.post("/search", body: { t: t, as_of: date.to_s(:db) })

    raise ApiEntity::Error if response.code == 500

    Outcome.new(response)
  end

  def t=(t)
    @t = t.to_s.gsub(/(\[|\])/,'')
  end

  def q
    'trade_tariff'
  end

  def countries(geographical_area_klass = GeographicalArea)
    @countries ||= geographical_area_klass.countries.sort_by(&:description)
  end

  def date
    @date ||= if as_of.present?
                TariffDate.new(as_of)
              else
                TariffDate.parse(attributes.slice(*TariffDate::DATE_KEYS))
              end
  end

  def filtered_by_date?
    date.date != Date.today
  end

  def filtered_by_country?
    country.present?
  end

  def any_filter_active?
    filtered_by_date? || filtered_by_country?
  end

  def contains_search_term?
    t.present?
  end

  def query_attributes
    { 'day'  => date.day,
      'year' => date.year,
      'month' => date.month }.merge(attributes.slice(:country))
  end

  def country_name
    countries.detect { |c| c.geographical_area_id == attributes['country'] }
  end

  def to_s
    t
  end
end
