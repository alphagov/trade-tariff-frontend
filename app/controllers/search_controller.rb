class SearchController < ApplicationController
  def search
    @results = @search.perform
  end
end
