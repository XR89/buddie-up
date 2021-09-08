Rails.application.routes.draw do
  root to: 'pages#home'
  get '/welcome', to: 'pages#welcome', as: 'welcome'
  devise_for :users
  get '/profile', to: 'users#profile', as: 'profile'

  resources :users, only: %i[index show] do

    resources :favourite_users, only: %i[create destroy]
    resources :avoid_users, only: %i[create]
    # member do
    #   get 'favourite_users/create'
    #   get 'favourite_users/destroy'
    #   get 'avoid_users/create'
    # end
    patch '/accept/:id', to: 'invitations#accept', as: 'accept'
    patch '/decline/:id', to: 'invitations#decline', as: 'decline'
    # resources :invitations, only: :update
  end

  resources :games, only: %i[index show] do
    resources :favourite_games, only: %i[create destroy]
  end

  patch '/game_sessions/:id/start', to: 'game_sessions#start_game_session', as: 'start_game_session'
  patch '/game_sessions/:id/end', to: 'game_sessions#end_game_session', as: 'end_game_session'
  resources :game_sessions, only: %i[show create] do
    resources :user_ratings, only: %i[new create]
    resources :messages, only: :create
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
