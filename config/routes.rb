W3triadCom::Application.routes.draw do
  get "users/show"

  root :to => "posts#index"
  resources :posts

  match '/admin'             => "sessions#new",     :as => "login"
  match '/admin/logout'      => "sessions#destroy", :as => "logout"
  resources :sessions

  match '/:nickname'         => "users#show",       :as => "profile"
end
