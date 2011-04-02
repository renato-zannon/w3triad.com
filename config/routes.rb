W3triadCom::Application.routes.draw do
  root :to => "posts#index"
  resources :posts

  match '/admin', :to => "sessions#new"
end
