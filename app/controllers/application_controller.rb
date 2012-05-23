class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_search

  private

  def initialize_search
    @search = CommoditySearch.new(params)
  end
end
