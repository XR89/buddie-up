Rails.application.routes.draw do

  get '/welcome', to: 'pages#welcome'
  devise_for :users
  get '/profile', to: 'users#profile', as: :profile
  resources :users, only: %i[index show] do
    resources :user_ratings, only: %i[new create], as: :ratings
  end
  resources :games, only: %i[index show]
  resources :session, only: %i[show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
