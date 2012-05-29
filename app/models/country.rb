require 'api_entity'

class Country
  include ApiEntity

  attr_accessor :id, :name
end
