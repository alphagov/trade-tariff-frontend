require 'api_entity'

class AdditionalCode
  include ApiEntity

  attr_accessor :id, :code, :description
end
