FutureGame::Application.routes.draw do

  # Maps the user account related paths
  resource :users, path: "account"
  match 'my_account', to: "users#show", as: :my_account

  root :to => 'home#index'
end
