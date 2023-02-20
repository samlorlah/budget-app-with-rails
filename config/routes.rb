Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#splash'

  resources :users, only: [:splash]
  resources :groups, only: [:index]
end
