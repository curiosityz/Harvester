Rails.application.routes.draw do
  get 'datasets/new_upload', to: 'datasets#new_upload'
  get 'terms/recrawl', to: 'terms#recrawl'
  get 'datasets/recrawl_collection', to: 'datasets#recrawl_collection'
  post 'datasets/recrawl_items', to: 'datasets#recrawl_items'
  post 'relay_results', to: 'dataitems#save_results'
  post 'update_status', to: 'dataitems#save_status_message'
  
  resources :datasets
  resources :terms
  resources :dataitems
  # NLP Analysis routes
  get 'nlp_analysis/analyze_all', to: 'nlp_analysis#analyze_all'
  get 'nlp_analysis/analyze_document', to: 'nlp_analysis#analyze_document'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'datasets#index'

  # Sources
  get 'datasources', to: 'datasets#sources'

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
