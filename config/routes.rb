Rails.application.routes.draw do
  root to: 'pages#home'
  get '/welcome', to: 'pages#welcome'
  devise_for :users
  get '/profile', to: 'users#profile', as 'profile'
  resources :users, only: %i[index show]
  resources :games, only: %i[index show]
  resources :session, only: %i[show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
