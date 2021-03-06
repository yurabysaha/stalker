Rails.application.routes.draw do

  resources :users, :user_profile, :sessions, :location, :factory, :item, :user_item, :fight, :market

  get '/work/:id' => 'factory#work', as: 'work'
  get 'factory_items/:id' => 'item#factory_items', as: 'factory_items'
  get '/buy/:id' => 'user_item#buy', as: 'buy'
  post '/sold/:id' => 'user_item#sold', as: 'sold'
  get '/add_item/:id' => 'user_body#add_item', as: 'add_item'
  get '/down_item' => 'user_body#down_item', as: 'down_item'
  get '/fight/:id/battle' => 'fight#battle', as: 'battle'
  post "/fight/:id/battle" => 'fight#battle'
  get '/fight/:id/end' => 'fight#end', as: 'end'

  get '/market/buy/:id' => 'market#buy_on_market', as: 'mbuy'

  get '/signup'  => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sessions#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
