Rails.application.routes.draw do
  root 'shoes#index'
  devise_for :users
  resources :shoes
  resources :user_shoes
end
