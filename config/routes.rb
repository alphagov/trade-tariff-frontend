require 'trade_tariff_frontend'

TradeTariffFrontend::Application.routes.draw do
  scope path: "#{APP_SLUG}" do
    get "/", to: "pages#index"
    get "healthcheck" => "healthcheck#check"
    get "opensearch", to: "pages#opensearch", constraints: { format: :xml }
    get "terms", to: "pages#terms"
    get "cookies", to: "pages#cookies"
    match "/search" => "search#search", via: :get, as: :perform_search
    match "a-z-index/:letter" => "search_references#show",
          via: :get,
          as: :a_z_index,
          constraints: { letter: /[a-z]{1}/i }

    constraints TradeTariffFrontend::ApiConstraints.new(
      TradeTariffFrontend.accessible_api_endpoints
    ) do
      match ':endpoint/(*path)',
        via: :get,
        to: TradeTariffFrontend::RequestForwarder.new(
          host: Rails.application.config.api_host,
          api_request_path_formatter: ->(path) {
            path.gsub("#{APP_SLUG}/", "")
          }
        )
    end

    resources :sections, only: [:index, :show]
    resources :chapters, only: [:index, :show] do
      resources :changes,
                only: [:index],
                defaults: { format: :atom },
                module: 'chapters'
    end
    resources :headings, only: [:index, :show] do
      resources :changes,
                only: [:index],
                defaults: { format: :atom },
                module: 'headings'
    end
    resources :commodities, only: [:index, :show] do
      resources :changes,
                only: [:index],
                defaults: { format: :atom },
                module: 'commodities'
    end
  end

  root to: redirect("/#{APP_SLUG}", status: 302)

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  match "/503", to: "errors#maintenance", via: :all
end
