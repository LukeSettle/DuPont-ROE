Rails.application.routes.draw do
  resources :companies
  resources :searches
  root to: 'companies#index'
end
