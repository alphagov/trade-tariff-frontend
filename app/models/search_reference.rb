require 'api_entity'

class SearchReference
  include ApiEntity

  collection_path '/search_references'

  attr_accessor :id, :title, :reference_class

  def referenced_entity
    reference_class.new(attributes['referenced_entity'])
  end

  private

  def reference_class
    attributes['reference_class'].constantize
  end
end
