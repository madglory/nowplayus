Nowplayus::Application.routes.draw do

  resources :users do
    resources :platform_accounts, only: [:new, :create, :destroy]
    resources :notification_settings, only: [:edit, :update]
  end

  resources :clans, only: [:show, :index]
  resources :comments, only: [:show]
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
  match '/unwatch/:user_id_and_id', to: 'notification_subscriptions#destroy', via: :get

  match '/auth/:provider/callback', to: 'sessions#create', via: :get
  match '/auth/failure', to: 'sessions#destroy', via: :get
  match '/login', to: 'sessions#new', as: :login
  match '/logout', to: 'sessions#destroy', as: :logout

  match '/contest', to: 'home#contest', as: :contest

  root to: 'home#index'
end
