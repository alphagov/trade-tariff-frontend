require 'api_entity'

class GeographicalArea
  include ApiEntity

  attr_accessor :iso_code, :description, :geographical_area_id

  has_many :children_geographical_areas, class_name: 'GeographicalArea'

  class << self
    def countries
      resp = get("/geographical_areas/countries")
      case resp.code
      when 404
        raise ApiEntity::NotFound.new resp['error']
      when 500
        raise ApiEntity::Error.new resp['error']
      when 502
        raise ApiEntity::Error.new "502 Bad Gateway"
      end
      resp.map { |entry_data| new(entry_data) }
    end
  end

  def group_key
    children_geographical_areas.any? ? "0" : "1"
  end

  def description
    attributes['description'].presence || ''
  end

  def to_s
    description
  end
end
