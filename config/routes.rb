Nowplayus::Application.routes.draw do

  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users do 
    resources :events do
      resources :participants, only: [:create, :destroy]
    end
    resources :platform_accounts, only: [:new, :create, :destroy]
  end

  match 'complete_registration' => 'users#complete_registration', as: :complete_registration
  match 'confirm_registration' => 'users#confirm_registration', via: :put
  match 'change_password' => 'users#change_password', as: :change_password
  match 'update_password' => 'users#update_password', via: :put
  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
    
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  root :to => 'home#index'
end
