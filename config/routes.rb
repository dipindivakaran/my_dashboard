MyDashboard::Application.routes.draw do
  get "users/signup"

  get "users/login"

  get "users/logout"

  get "sessions/new"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :todo_lists
  resources :categories
  resources :users
  

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  root :to => 'todo_lists#home'
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
  # match ':controller(/:action(/:id))(.:format)'
   match '/home' => 'todo_lists#home' , :as => 'home'
   match '/get_tab_items' => 'categories#get_tab_items' , :as => 'get_tab_items'
   match '/get_categories' => 'categories#get_categories' , :as => 'get_categories'
   match '/post_todo' => 'todo_lists#post_todo' , :as => 'post_todo'
   match '/get_posts' => 'todo_lists#get_posts' , :as => 'get_posts'
   match '/update_attribute' => 'todo_lists#update_attribute' , :as => 'update_attribute'
  
   
   match '/login' => 'users#login' , :as => 'login'
   match '/logout' => 'users#logout' , :as => 'logout'
   match '/validate_login' => 'users#validate_login' , :as => 'validate_login'
   
   match 'auth/google_oauth2/callback' => 'users#auth2callback'
   
end
