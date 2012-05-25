require 'api_entity'

class Region
  include ApiEntity

  attr_accessor :id, :name, :iso_code, :description, :type

  def to_s
    name
  end

  def blank?
    id.present?
  end
end
