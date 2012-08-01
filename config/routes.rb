TariffWeb::Application.routes.draw do
  match "/search" => "search#search", via: :get, as: :perform_search

  resources :sections, only: [:index, :show]
  resources :chapters, only: [:index, :show]
  resources :headings, only: [:index, :show] do
    member do
      get :import_measures
      get :export_measures
    end
  end
  resources :commodities, only: [:index, :show, :edit, :update] do
     member do
      get :import_measures
      get :export_measures
    end
  end

  root to: 'pages#index'
end
