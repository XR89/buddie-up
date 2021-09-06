Rails.application.routes.draw do

  root to: 'pages#home'
  get '/welcome', to: 'pages#welcome', as: 'welcome'
  devise_for :users
  get '/profile', to: 'users#profile', as: 'profile'

  resources :users, only: %i[index show] do
    patch '/accept/:id', to: 'invitations#accept', as: 'accept'
    patch '/decline/:id', to: 'invitations#decline', as: 'decline'
    # resources :invitations, only: :update
  end
  resources :games, only: %i[index show]
  resources :game_sessions, only: %i[show create] do
    resources :user_ratings, only: %i[new create]
    resources :messages, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
