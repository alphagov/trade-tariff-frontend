class SearchReferencePresenter
  attr_reader :search_reference, :referenced_entity

  delegate :link, to: :referenced_entity

  def initialize(search_reference)
    @search_reference = search_reference
    @referenced_entity = presenter_for(
      search_reference.referenced_entity
    ).new(search_reference.referenced_entity)
  end

  def to_s
    search_reference.title.titleize
  end

  private

  def presenter_for(referenced_entity)
    "#{referenced_entity.class}Presenter".classify.constantize
  end

  def method_missing(*args, &block)
    @search_reference.send(*args, &block)
  end
end
