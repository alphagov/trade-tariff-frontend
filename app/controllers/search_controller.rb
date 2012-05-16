class SearchController < ApplicationController
  # GET /show.html
  def show
  end

  # POST /search.html
  def search
    render action: 'show'
  end
end
