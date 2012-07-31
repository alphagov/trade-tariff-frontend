require 'api_entity'
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_modules
  before_filter :cache_all_the_things

  layout :set_layout

  rescue_from Errno::ECONNREFUSED do |e|
    render text: '', status: :error
  end
  rescue_from ApiEntity::NotFound do ||
    render text: '404', status: 404
  end
  rescue_from ApiEntity::Error do |e|
    render text: '', status: :error
  end

  def url_options
    { date: @tariff_date }.merge(super)
  end

  private

  def initialize_modules
    @search = Search.new(params)
    @tariff_date = TariffDate.new(params[:date])
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

  def cache_all_the_things
    expires_in 6.hours, :public => true, 'max-stale' => 0
  end
end
