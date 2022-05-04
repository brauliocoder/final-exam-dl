Rails.application.routes.draw do
  resources :spaces
  resources :products
  resources :orders
  resources :memberships
  resources :roles
  resources :channels
  get 'home/index'
  resources :warehouses
  resources :headquarters
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
