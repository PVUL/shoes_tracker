Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  resources :shoes, only: [:index, :shoe, :destroy, :show] do
    resources :check_ins, only: [:create]
  end
  resources :user_shoes, only: [:new, :create]

  authenticated :user do
    root 'shoes#index', as: 'authenticated_root'
  end

  root 'welcome#index'
end
