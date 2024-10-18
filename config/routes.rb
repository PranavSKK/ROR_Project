# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [:index, :show] do
    resources :loans, only: [:new, :create, :update, :show]  # Added :show here
  end

  namespace :admin do
    resources :loans, only: [:index, :new, :create, :update, :show, :edit]
  end
  
  root 'users#index'
end

