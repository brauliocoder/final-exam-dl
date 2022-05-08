Rails.application.routes.draw do
  root 'home#index'
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

    resources :orders
    get '/:channel_id/cashbox_mode/', to: 'orders#cashbox_mode', as: 'cashbox_mode'

    resources :products

    # Restringir acceso a CRUD
    resources :roles, only: [:show, :index]
    
    # delete ':channel_id/cashbox', to: 'friedman#remove_to_cart', as: 'remove_to_cart'
    # get ':channel_id/cashbox', to: 'friedman#complete_transaction', as: 'cashbox_mode'

    resources :warehouses do
      resources :spaces
    end
  end
end
