require "api_entity"
require "slimmer/headers"
require "gds_api/helpers"

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Slimmer::Headers
  include GdsApi::Helpers
  include TradeTariffFrontend::ViewContext::Controller

  before_filter :set_cache
  before_filter :load_artefact
  before_filter :search_query

  after_filter :set_app_slimmer_headers

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

  rescue_from URI::InvalidURIError do |e|
    render text: '404', status: 404
  end

  def url_options
    search_invoked? ? { year: search_query.date.year,
                        month: search_query.date.month,
                        day: search_query.date.day,
                        country: search_query.country }.merge(super) : super
  end

  private

  def search_invoked?
    params[:q].present? || params[:day].present? || params[:country].present?
  end

  def search_query
    @search ||= Search.new(params)
  end

  def set_layout
    if request.headers['X-AJAX']
      response.headers[Slimmer::Headers::SKIP_HEADER] = "true"
      false
    else
      "application"
    end
  end

  def query_params
    { query: { as_of: search_query.date } }
  end

  def set_cache
    unless Rails.env.development?
      expires_in 2.hours, :public => true, 'stale-if-error' => 86400, 'stale-while-revalidate' => 86400
    end
  end

  def load_artefact
    unless Rails.env.development? #remove me once I rebuild my vm
      @artefact = content_api.artefact(APP_SLUG)
      set_slimmer_artefact(@artefact)
    end
  end

  def set_app_slimmer_headers
    unless Rails.env.development? #remove me once I rebuild my vm
      set_slimmer_headers(
        format:               "custom-tool",
        remove_meta_viewport: true
      )
    end
  end
end
