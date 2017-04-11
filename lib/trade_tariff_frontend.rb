require 'trade_tariff_frontend/api_constraints'
require 'trade_tariff_frontend/request_forwarder'

module TradeTariffFrontend
  autoload :Presenter,      'trade_tariff_frontend/presenter'
  autoload :ViewContext,    'trade_tariff_frontend/view_context'

  module_function

  # API Endpoints of the Tariff API app that can be reached
  # via Frontend
  def accessible_api_endpoints
    ['sections', 'chapters', 'headings', 'commodities', 'updates']
  end

  def production?
    ENV["GOVUK_APP_DOMAIN"] == "tariff-frontend-production.cloudapps.digital"
  end
end
