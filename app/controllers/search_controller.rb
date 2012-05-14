class SearchController < ApplicationController
  before_filter :initialize_search

  # GET /show.html
  def show
  end

  # POST /search.html
  def search
    render action: 'show'
  end

  private

  def initialize_search
    @search = Search.new(params[:search])
  end
end
