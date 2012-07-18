require 'api_entity'

class LegalAct
  include ApiEntity

  attr_accessor :generating_regulation_code, :url
end
