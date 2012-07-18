require 'api_entity'

class AdditionalCode
  include ApiEntity

  attr_accessor :code, :description

  def to_s
    code
  end
end
