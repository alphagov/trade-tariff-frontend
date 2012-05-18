class SearchController < ApplicationController
  # POST /search.html
  def search
    @results = Search.new(params).perform
  end
end
