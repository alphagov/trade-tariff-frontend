class SearchController < ApplicationController
  # POST /search.html
  def search
    @results = Search.new(params[:search]).perform
  end
end
