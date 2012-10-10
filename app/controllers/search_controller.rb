class SearchController < ApplicationController
  def search
    @results = @search.perform

    redirect_to url_for(@results.to_param.merge(url_options)) if @results.exact_match?
  end
end
