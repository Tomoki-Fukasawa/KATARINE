Rails.application.routes.draw do
  devise_for :users
  
  root to: 'boards#index'

  resources :users, only: [:show,:index] do
    patch :friend_want,on: :collection
  end
  resources :boards do
    resources :comments,only: :create
  end
end
