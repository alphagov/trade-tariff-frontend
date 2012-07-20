class SearchController < ApplicationController
  def search
    @result = @search.perform

    redirect_to url_for(@result.match_path) if @result.exact_match?
  end
end
