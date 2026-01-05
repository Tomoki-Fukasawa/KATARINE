Rails.application.routes.draw do
  devise_for :users
  root to: 'boards#index'
  resources :boards, only: [:index,:new,:create]
    resources :comments,only: :create
  end
end
