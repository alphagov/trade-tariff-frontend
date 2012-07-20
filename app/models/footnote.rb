require 'api_entity'

class Footnote
  include ApiEntity

  attr_accessor :code, :description

  def id
    @id ||= SecureRandom.hex(16)
  end
end
