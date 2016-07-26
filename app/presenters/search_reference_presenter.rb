class SearchReferencePresenter
  attr_reader :search_reference

  def initialize(search_reference)
    @search_reference = search_reference
  end

  def to_s
    search_reference.title.titleize
  end

  def link
    "/#{APP_SLUG}/#{referenced_class.tableize}/#{referenced_id}"
  end

  private

  def method_missing(*args, &block)
    @search_reference.send(*args, &block)
  end
end
