W3triadCom::Application.routes.draw do
  root :to => "posts#index"
  resources :posts

  match '/admin'             => "sessions#new",     :as => "login"
  match '/admin/logout'      => "sessions#destroy", :as => "logout"
  resources :sessions
end
