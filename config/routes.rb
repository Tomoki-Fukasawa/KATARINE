Rails.application.routes.draw do
  devise_for :users
  
  root to: 'users#index'

  resources :users, only: [:show,:index] do
    # patch :friend_want,on: :collection
    patch :friend_want,on: :member
    member do
      get :friends
    end
  end
  resources :boards do
    resources :comments,only: :create
  end

  resources :friendships, only: [:create, :update, :destroy] do
    member do
      patch :reject
    end
  end

  resources :chat_rooms, only: [:index,:show] do
    resources :messages, only: [:create, :destroy]
  end
  resources :items do
    resources :item_requests, only:[:index,:create,:destroy] do
      member do
        patch :accept
        patch :complete
      end
    end
  end
  resource :mypage, only: [:show] 
end