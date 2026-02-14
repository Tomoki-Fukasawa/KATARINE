Rails.application.routes.draw do
  devise_for :users
  
  root to: 'boards#index'

  resources :users, only: [:show,:index] do
    # patch :friend_want,on: :collection
    patch :friend_want,on: :member
  end
  resources :boards do
    resources :comments,only: :create
  end

  resources :friendships, only: [:create, :update]
end
