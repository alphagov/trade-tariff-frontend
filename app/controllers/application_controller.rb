require "api_entity"
require "gds_api/helpers"

class ApplicationController < ActionController::Base
  protect_from_forgery
  include GdsApi::Helpers
  include TradeTariffFrontend::ViewContext::Controller

  before_filter :set_last_updated
  before_filter :set_cache
  before_filter :search_query
  before_filter :bots_no_index_if_historical

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

  def set_last_updated
    @tariff_last_updated ||= Rails.cache.fetch(
      "tariff_last_updated",
      expires_in: 1.hour
    ) do
      last = TariffUpdate.all.first
      last ? last.updated_at : nil
    end
  end

  def search_invoked?
    params[:q].present? || params[:day].present? || params[:country].present?
  end

  def search_query
    @search ||= Search.new(params)
  end

  def set_layout
    if request.headers['X-AJAX']
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

  protected

  def bots_no_index_if_historical
    response.headers["X-Robots-Tag"] = "none" unless @search.today?
  end
end
