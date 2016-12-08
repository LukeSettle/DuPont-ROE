Rails.application.routes.draw do
  devise_for :users
  resources :companies
  root to: 'companies#index'
end
