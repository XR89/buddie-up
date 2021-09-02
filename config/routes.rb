Rails.application.routes.draw do
  root to: 'pages#home'
  get '/welcome', to: 'pages#welcome', as: 'welcome'
  devise_for :users
  get '/profile', to: 'users#profile', as: 'profile'
  resources :users, only: %i[index show]
  resources :games, only: %i[index show]
<<<<<<< HEAD
  resources :game_session, only: %i[show] do
=======
  resources :game_sessions, only: %i[show] do
>>>>>>> master
    resources :user_ratings, only: %i[new create], as: :ratings
    resources :messages, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
