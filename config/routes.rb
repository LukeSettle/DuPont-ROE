Rails.application.routes.draw do
  resources :companies
  root to: 'companies#index'
end
