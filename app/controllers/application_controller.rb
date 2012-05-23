class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_search

  rescue_from Errno::ECONNREFUSED do |e|
    render text: '', status: :error
  end

  private

  def initialize_search
    @search = CommoditySearch.new(params)
  end
end
