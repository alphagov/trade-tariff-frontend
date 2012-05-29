Uktt::Application.routes.draw do
  match "/search" => "search#search", via: :get, as: :perform_search

  resources :sections, only: [:index, :show]
  resources :chapters, only: [:index, :show]
  resources :headings, only: [:index, :show]
  resources :commodities, only: [:index, :show, :edit, :update]

  root to: 'sections#index'
end
