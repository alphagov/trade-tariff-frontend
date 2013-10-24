require 'api_entity'

class Footnote
  include ApiEntity

  attr_accessor :code, :description, :formatted_description

  def id
    @id ||= "#{casted_by.destination}-#{casted_by.id}-footnote-#{code}"
  end
end
