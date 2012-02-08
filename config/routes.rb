Pdf::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :deals do
    get :filter, :on => :collection
    get :search, :on => :collection
    get :tweet_search, :on=> :collection
    get :scrolldata , :on=> :collection
  end
  

 
  
  #~ match '/admin/search_terms/:id', :to => 'admin/search_terms#show'
  match "/auth/:provider/callback" => "sessions#create"
  match '/auth/failure', :to => 'sessions#failure'
  match "/signout" => "sessions#destroy", :as => :signout
  match "/howto" => "pages#howto", :as => :howto

  root :to => 'deals#index'
  root :to => 'search_terms#index'
end
