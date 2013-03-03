Nowplayus::Application.routes.draw do

  resources :users do
    resources :platform_accounts, only: [:new, :create, :destroy]
  end

  resources :games do
    get :autocomplete_game_name, :on => :collection
  end

  resources :events do
    resources :participants, only: [:create, :destroy]
    resources :event_tweets, only: [:new, :create]
    resources :comments
  end

  match '/complete_registration', to: 'users#complete_registration', as: :complete_registration
  match '/confirm_registration', to: 'users#confirm_registration', via: :put

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/login', to: 'sessions#new', as: :login
  match '/logout', to: 'sessions#destroy', as: :logout

  get "/contest" => 'home#contest'

  root :to => 'home#index'
end
