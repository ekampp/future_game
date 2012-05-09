FutureGame::Application.routes.draw do

  # Maps the characters
  # TODO: Move this under the users, when testing for shallow, scoped routes is
  #       figured out. <emil@kampp.me>
  resources :characters

  # Maps the user account related paths
  match 'my_account', to: "users#edit", as: :my_account
  resources :users, path: "account", only: [ :update, :destroy, :edit ]

  # Maps login session paths
  resource :sessions, only: [ :new, :create, :destroy ]
  match 'login', to: "sessions#new", as: :login
  match 'logout', to: "sessions#destroy", as: :logout
  match 'auth/developer/callback', to: "sessions#create"

  root :to => 'home#index'
end
