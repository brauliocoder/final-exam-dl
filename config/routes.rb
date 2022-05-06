Rails.application.routes.draw do
  root to: 'friedman#index'
  devise_for :users

  authenticate :user do
    resources :headquarters do
      
      resources :channels
      resources :memberships
    end
    
    get '/connect_warehouse/:id', to: 'headquarters#connect_warehouse', as: 'connect_warehouse'
    get '/connect_headquarter/:id', to: 'warehouses#connect_headquarter', as: 'connect_headquarter'

    resources :warehouses do
      resources :spaces
    end
    
    resources :products
    resources :orders

    resources :roles
  end
end
