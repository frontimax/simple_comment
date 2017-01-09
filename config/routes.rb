Rails.application.routes.draw do
  
  # bug user create via devise route/registration
  post 'users' => 'users#create'
  
  devise_for :users
  root 'articles#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'articles/inactive' => 'articles#index_inactive'
  
  # scaffold defaults
  resources :comments
  resources :articles
  resources :users
  
end
