require 'api_entity'

class GeographicalArea
  include ApiEntity

  attr_accessor :iso_code, :description

  has_many :children_geographical_areas, class_name: 'GeographicalArea'

  def type
    children_geographical_areas.any?
  end
end
