Rails.application.routes.draw do
  root to: 'friedman#index'
  devise_for :users

  authenticate :user do
    resources :headquarters do
      resources :channels
      resources :memberships
    end

    resources :warehouses do
      resources :spaces
    end

    get '/your_channels/', to: 'friedman#user_channels', as: 'your_channels'

    resources :products
    resources :orders

    resources :roles
  end
end
