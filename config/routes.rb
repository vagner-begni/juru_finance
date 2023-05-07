Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root to: 'home#index'
  #get '/users', to: 'users#index', as: 'users'

  resources :users, only: [:index, :destroy] do
    post 'admin', on: :member
    post 'financial', on: :member
    post 'employee', on: :member
    post 'resident', on: :member
  end
end
