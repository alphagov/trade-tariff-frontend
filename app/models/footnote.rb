require 'api_entity'

class Footnote
  include ApiEntity

  attr_accessor :id, :code, :description
end
