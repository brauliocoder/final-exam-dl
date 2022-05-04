Rails.application.routes.draw do
  root to: 'friedman/index'
  devise_for :users

  authenticate :user do
    resources :headquarters do
      resources :channels
    end

    resources :warehouses do
      resources :spaces
    end
    
    resources :products
    resources :orders

    resources :memberships
    resources :roles
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
