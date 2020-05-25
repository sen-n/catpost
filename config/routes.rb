Rails.application.routes.draw do

  root to: 'toppages#index'
  
  resources :posts
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update]
end
