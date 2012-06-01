class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_search

  layout :set_layout

  rescue_from Errno::ECONNREFUSED do |e|
    render text: '', status: :error
  end

  private

  def initialize_search
    @search = CommoditySearch.new(params)
  end

  def set_layout
    if request.headers['X-PJAX']
      response.headers[Slimmer::SKIP_HEADER] = "true"
      "pjax"
    elsif request.headers['X-AJAX']
      response.headers[Slimmer::SKIP_HEADER] = "true"
      false
    else
      "application"
    end
  end
end
