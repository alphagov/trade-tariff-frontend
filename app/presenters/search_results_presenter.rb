class SearchResultsPresenter
  SUGGESTION_COUNT = 10

  def initialize(search_results)
    @search_results = search_results
  end

  def as_json(opts = {})
    [
      @search_results.reference_match.sections.map(&:to_s),
      @search_results.reference_match.chapters.map(&:to_s),
      @search_results.reference_match.headings.map(&:to_s),
      @search_results.goods_nomenclature_match.sections.map(&:to_s),
      @search_results.goods_nomenclature_match.chapters.map(&:to_s),
      @search_results.goods_nomenclature_match.headings.map(&:to_s),
      @search_results.goods_nomenclature_match.commodities.map(&:to_s)
    ].flatten.first(SUGGESTION_COUNT).reject(&:blank?)
  end
end
