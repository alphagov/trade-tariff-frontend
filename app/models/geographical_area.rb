require 'api_entity'

class GeographicalArea
  include ApiEntity

  attr_accessor :iso_code, :description

  has_many :children_geographical_areas, class_name: 'GeographicalArea'

  def group_key
    children_geographical_areas.any? ? "0" : "1"
  end

  def description
    attributes['description'].presence || ''
  end
end
