require 'api_entity'

class Footnote
  include ApiEntity

  attr_accessor :code, :description
end
