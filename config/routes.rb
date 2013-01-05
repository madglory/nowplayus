Nowplayus::Application.routes.draw do

  resources :user_sessions
  resources :users do 
    resources :events do
        get 'players/join' => "players#join"
        get 'players/leave' => "players#leave"
    end
  end

  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
    
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  root :to => 'users#index'
end
