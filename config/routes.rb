Rails.application.routes.draw do

  get 'answers/new'
  get 'favorites/index'
  get 'sessions/new'
  root 'pages#index'
  get 'pages/help'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :questions

  get "favorites/index"
  post "/favorites", to: "favorites#create"
  delete "/favorites", to: "favorites#destroy"

  resources :questions do
    resources :answers
  end
  resources :answers
end
