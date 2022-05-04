Rails.application.routes.draw do
  root to: 'friedman#index'
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
end
