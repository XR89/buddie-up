Rails.application.routes.draw do
  root to: 'pages#home'
  get '/welcome', to: 'pages#welcome', as: 'welcome'
  devise_for :users
  get '/profile', to: 'users#profile', as: 'profile'

  resources :users, only: %i[index show] do
    resources :favourite_users, only: %i[create destroy]
    resources :avoid_users, only: %i[create destroy index]
    patch '/accept/:id', to: 'invitations#accept', as: 'accept'
    patch '/decline/:id', to: 'invitations#decline', as: 'decline'
    # resources :invitations, only: :update
  end

  resources :games, only: %i[index show] do
    resources :favourite_games, only: %i[create destroy]
  end

  patch '/chats/:id/start', to: 'chats#start_chat', as: 'start_chat'
  patch '/chats/:id/end', to: 'chats#end_chat', as: 'end_chat'
  resources :chats, only: %i[show create index] do
    resources :messages, only: :create
    resources :user_ratings, only: %i[new create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
