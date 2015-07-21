Rails.application.routes.draw do
  # root 'shoes#index'
  devise_for :users
  get 'welcome/index'
  resources :shoes, only: [:index, :shoe, :destroy] do
    resources :check_ins
  end
  resources :user_shoes, only: [:new, :create]

  authenticated :user do
    root 'shoes#index', as: 'authenticated_root'
  end

  root 'welcome#index'
end
