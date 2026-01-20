Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: 'users#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'boards#index', as: :unauthenticated_root
  end
  resources :users, only: [:show,:index]
    patch :friend_want,on: :collection
  end
  resources :boards do
    resources :comments,only: :create
  end
end
