Uktt::Application.routes.draw do
  match "/search" => "search#search", via: :post, as: :perform_search

  resources :sections do
    resources :chapters do
      resources :commodities
    end
  end

  root to: 'search#show'
end
