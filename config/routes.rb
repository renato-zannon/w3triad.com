W3triadCom::Application.routes.draw do
  get "users/show"

#  root :to => "posts#index"
  match '/posts/preview'     => "posts#preview",      :as => "preview_post"
  match '/posts/:id/edit'    => "posts#edit",         :as => "edit_post"
  resources :posts

  match '/admin'             => "sessions#new",       :as => "login"
  match '/admin/logout'      => "sessions#destroy",   :as => "logout"
  resources :sessions

  match '/:nickname'         => "users#show",         :as => "profile",      :method => :get
  match '/admin/:id/edit'    => "users#edit_profile", :as => "edit_profile", :method => :get
  match '/admin/:id'         => "users#update",       :as => "update_user",  :method => :put
end
