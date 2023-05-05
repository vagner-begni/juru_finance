Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root to: 'home#index'
  get '/users', to: 'users#index', as: 'users'
end
