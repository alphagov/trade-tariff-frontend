class SearchResultsPresenter
  SUGGESTION_COUNT = 10

  def initialize(search_results)
    @search_results = search_results
  end

  def as_json(opts = {})
    flattened_search_results.first(SUGGESTION_COUNT).reject(&:blank?).map(&:titlecase)
  end

  private

  def flattened_search_results
    [
      @search_results.goods_nomenclature_match.sections.map(&:to_s),
      @search_results.goods_nomenclature_match.chapters.map(&:to_s),
      @search_results.goods_nomenclature_match.headings.map(&:to_s),
      @search_results.goods_nomenclature_match.commodities.map(&:to_s)
    ].flatten
  end
end
