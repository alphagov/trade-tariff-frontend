TradeTariffFrontend.faraday = Faraday.new(url: Rails.application.config.api_host) do |faraday|
  faraday.request :json
  faraday.response :json, :content_type => /\bjson$/
  faraday.adapter Faraday.default_adapter
end
