Nowplayus::Application.routes.draw do

  resources :users do
    resources :platform_accounts, only: [:new, :create, :destroy]
  end

  resources :clans

  resources :games, only: [:show, :index]
  resources :notification_subscriptions, only: [:destroy]
  resources :events do
    resources :notification_subscriptions, only: [:create]
    resources :participants, only: [:create, :destroy]
    resources :event_tweets, only: [:new, :create]
    resources :comments, only: [:create]
  end

  match '/complete_registration', to: 'users#complete_registration', as: :complete_registration
  match '/confirm_registration', to: 'users#confirm_registration', via: :put

  match '/auth/:provider/callback', to: 'sessions#create', via: :get
  match '/auth/failure', to: 'sessions#destroy', via: :get
  match '/login', to: 'sessions#new', as: :login
  match '/logout', to: 'sessions#destroy', as: :logout

  root to: 'home#index'
end
