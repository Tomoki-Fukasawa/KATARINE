Rails.application.routes.draw do
  devise_for :users
  root to: 'boards#index'
  resources :boards do
    resources :comments,only: :create
  end
  resources :users, only: :show
end
