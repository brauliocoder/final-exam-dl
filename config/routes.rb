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

    get '/memberships/', to: 'memberships#member_invitations', as: 'member_invitations'
    
    get '/connect_warehouse/:id', to: 'headquarters#connect_warehouse', as: 'connect_warehouse'
    get '/connect_headquarter/:id', to: 'warehouses#connect_headquarter', as: 'connect_headquarter'

    resources :orders
    get '/:channel_id/cashbox_mode/', to: 'orders#cashbox_mode', as: 'cashbox_mode'
    get '/:channel_id/history_mode/', to: 'orders#history_mode', as: 'history_mode'
    get '/:channel_id/stats_mode/', to: 'orders#stats_mode', as: 'stats_mode'
    
    post '/:channel_id/cashbox_mode/:product_id', to: 'orders#add_product', as: 'add_product'
    delete '/:channel_id/cashbox_mode/:product_id', to: 'orders#remove_product', as: 'remove_product'
    delete '/:channel_id/cashbox_mode/:product_id/remove_all', to: 'orders#remove_all_item', as: 'remove_all_item'
    
    post '/:channel_id/cashbox_mode/', to: 'orders#end_transaction', as: 'end_transaction'

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
