require 'api_entity'
require 'formatter'

class Footnote
  include ApiEntity
  include Models::Formatter

  attr_accessor :code, :description

  format :formatted_description, with: DescriptionFormatter,
                                using: :description

  def id
    @id ||= SecureRandom.hex(16)
  end
end
