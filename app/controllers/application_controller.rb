require 'api_entity'
require "slimmer/headers"
require 'gds_api/helpers'

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Slimmer::Headers
  include GdsApi::Helpers

  before_filter :initialize_modules
  before_filter :set_cache
  before_filter :load_artefact
  after_filter :set_analytics_headers

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
    { as_of: @tariff_date }.merge(super)
  end

  private

  def initialize_modules
    @search = Search.new(params)
    @tariff_date = TariffDate.new(params[:as_of])
  end

  def set_layout
    if request.headers['X-PJAX']
      response.headers[Slimmer::Headers::SKIP_HEADER] = "true"
      "pjax"
    elsif request.headers['X-AJAX']
      response.headers[Slimmer::Headers::SKIP_HEADER] = "true"
      false
    else
      "application"
    end
  end

  def query_params
    { query: { as_of: @tariff_date } }
  end

  def set_cache
    expires_in 2.hours, :public => true, 'max-stale' => 0
  end

  def load_artefact
    @artefact = content_api.artefact(APP_SLUG)
    set_slimmer_artefact(@artefact)
  end

  def set_analytics_headers
    headers = {
      format:      "trade-tariff",
    }
    set_slimmer_headers(headers)
  end
end
