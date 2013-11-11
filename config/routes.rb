require 'trade_tariff_frontend'

TradeTariffFrontend::Application.routes.draw do
  scope :path => "#{APP_SLUG}" do
    mount TradeTariffFrontend::RequestForwarder.new(
      host: Rails.application.config.api_host
    ), at: '/api'

    get "/" => "pages#index"
    get "healthcheck" => "healthcheck#check"
    match "/search" => "search#search", via: :get, as: :perform_search
    match "a-z-index/:letter" => "search_references#show",
          via: :get,
          as: :a_z_index,
          constraints: { letter: /[a-z]{1}/i }

    resources :sections, only: [:index, :show]
    resources :chapters, only: [:index, :show] do
      resources :changes, only: [:index], module: 'chapters'
    end
    resources :headings, only: [:index, :show] do
      resources :changes, only: [:index], module: 'headings'
    end
    resources :commodities, only: [:index, :show] do
      resources :changes, only: [:index], module: 'commodities'
    end
  end

  root :to => redirect("/#{APP_SLUG}", :status => 302)
end
