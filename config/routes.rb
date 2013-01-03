Whoneedsavisa::Application.routes.draw do
  get '/login', :to => 'sessions#new', :as => :login
  get '/logout', :to => 'sessions#destroy'
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  match '/comments/:country_id/:visa_id', :to => "comments#index"

  resources :countries
  resources :votes do
    get 'fb_comment', :on => :collection
  end
  resources :visas
  resources :comments
  resources :links

  root :to => "home#index"
end
