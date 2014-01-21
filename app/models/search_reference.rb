require 'api_entity'

class SearchReference
  include ApiEntity

  collection_path '/search_references'

  attr_accessor :id, :title, :referenced_id, :referenced_class

  def referenced_entity
    reference_class.new(attributes['referenced'])
  end

  private

  def reference_class
    attributes['referenced_class'].constantize
  end
end
