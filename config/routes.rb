FutureGame::Application.routes.draw do

  # Maps the user account related paths
  resource :users, path: "account"
  match 'my_account', to: "users#edit", as: :my_account
  match 'login', to: "sessions#new", as: :login
  match 'logout', to: "sessions#destroy", as: :logout
  resource :sessions, only: [ :new, :create, :destroy ]
  match 'auth/developer/callback', to: "sessions#create"

  root :to => 'home#index'
end
