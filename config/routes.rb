Rails.application.routes.draw do
  root to: 'friedman#index'
  devise_for :users

  authenticate :user do
    resources :headquarters do
      resources :channels
      resources :memberships
      get '/connect_warehouse/:id', to: 'memberships#connect_channels', as: 'connect_channels'
      get '/connect_members/:id', to: 'channels#connect_members', as: 'connect_members'
    end
    
    get '/connect_warehouse/:id', to: 'headquarters#connect_warehouse', as: 'connect_warehouse'
    get '/connect_headquarter/:id', to: 'warehouses#connect_headquarter', as: 'connect_headquarter'
    
    get ':channel_id/cashbox', to: 'friedman#cashbox_mode', as: 'cashbox_mode'

    resources :warehouses do
      resources :spaces
    end
    
    resources :orders
    resources :products

    # Restringir acceso a CRUD
    resources :roles, only: [:show, :index]
  end
  
end
