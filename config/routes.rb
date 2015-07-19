Rails.application.routes.draw do
  root 'shoes#index'
  devise_for :users
  resources :shoes, only: [:index, :shoe, :destroy] do
    resources :check_ins
  end
  resources :user_shoes, only: [:new, :create]
end
