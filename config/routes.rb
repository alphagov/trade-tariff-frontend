Uktt::Application.routes.draw do
  match "/search" => "search#search", via: :post, as: :perform_search

  root to: 'search#show'
end
