PryusBliss::Application.routes.draw do

  root :to => 'pages#index'
  

  resources :administrateurs
  resources :machines
  resources :salles
  resources :sessions, :only => [:new, :create, :destroy]

  match '/forgot_password', :to => 'administrateurs#forgot_password'
  match '/new_password_request', :to => 'administrateurs#new_password_request'
  match '/change_password_request', :to => 'administrateurs#change_password_request'
  match '/change_password_process', :to => 'administrateurs#change_password_process'
  match '/ping/:machine_id', :to => "machines#ping"
  match '/all_ping', :to => "machines#all_ping"
  match '/graph/:idmachine', :to => "charts#chart"
  match '/xml/:idmachine', :to => "charts#xml"
  match '/machine_historique/:id_machine' => 'pages#machine_historique'
  match '/incidents', :to => 'pages#incidents'
  match '/admin', :to => 'pages#admin'
  get "sessions/new"
  match '/signout',  :to => 'sessions#destroy'
  match '/signin',  :to => 'sessions#new'

  



  #Ajax
  match '/update_machine',  :to => 'machines#update_machine'
  match '/new_incident/:machine_id/:ping_service/:niveau/:description/:propriete', :to => 'machines#new_incident'
  match '/get_incident/:machine_id/:ping_service', :to => 'machines#get_incident'
  match '/update_incident/:machine_id/:ping_service', :to => 'machines#update_incident'
  match '/etat_machine/:machine_id', :to => 'machines#etat_machine'
  match '/update_menu', :to => 'pages#update_menu'


  resource :js do
    collection do
      get 'view'
      get 'data'
      get 'dbaction'
    end
  end



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
