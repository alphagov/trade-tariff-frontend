require 'api_entity'

class LegalAct
  include ApiEntity

  attr_accessor :id, :code, :url
end
