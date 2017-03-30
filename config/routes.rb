Rails.application.routes.draw do
  devise_for :users
  resources :products
  resources :categories
  resources :line_items
  resources :carts
  resources :orders

  root 'products#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
