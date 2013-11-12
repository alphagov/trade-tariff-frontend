class SearchPresenter
  def initialize(search, results)
    @search = search
    @search_results = SearchResultsPresenter.new(results)
  end

  def as_json(opts = {})
    [@search.t, @search_results.as_json(opts)]
  end
end
