class SearchReferencesPresenter
  attr_reader :search_references

  delegate :each, to: :search_references

  def initialize(search_references)
    @search_references = search_references.map { |search_reference|
      SearchReferencePresenter.new(search_reference)
    }
  end
end
