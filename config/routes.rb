Rails.application.routes.draw do
  devise_for :users
  
  # Define routes for cities
  resources :cities, only: [:index, :show]

  # Set the root path to the cities index page
  root 'cities#index'
end
