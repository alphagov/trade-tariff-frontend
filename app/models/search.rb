require 'api_entity'

class Search
  include ApiEntity

  attr_accessor :t, :as_of

  def perform
    response = self.class.post("/search", body: { t: t, as_of: as_of })

    raise ApiEntity::Error if response.code == 500

    Outcome.new(response)
  end

  def q
    'trade_tariff'
  end

  def to_s; t; end
end
