W3triadCom::Application.routes.draw do
  get "users/show"

#  root :to => "posts#index"
  match '/posts/preview'     => "posts#preview",      :as => "preview_post", :via => :get
  match '/posts/:id/edit'    => "posts#edit",         :as => "edit_post",    :via => :get
  resources :posts, :only    => [:new, :create, :show, :index]

  match '/admin'             => "sessions#new",       :as => "login",        :via => :get
  match '/admin/logout'      => "sessions#destroy",   :as => "logout",       :via => :get
  resources :sessions, :only => :create

  match '/:nickname'         => "users#show",         :as => "profile",      :via => :get, :nickname => /Bill|Azura|Zi/i
  match '/admin/:id/edit'    => "users#edit_profile", :as => "edit_profile", :via => :get
  match '/admin/:id'         => "users#update",       :as => "update_user",  :via => :put

  match '*page'              => "errors#not_found"
end
