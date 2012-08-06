class SearchController < ApplicationController
  def search
    @results = @search.perform

    redirect_to url_for(@results.match_path) if @results.exact_match?
  end
end
