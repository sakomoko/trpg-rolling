TrpgRolling::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  resources :worlds do
    resources :members do
      get :awaiting, :on => :collection
      put :apply, :on => :member
    end
    resources :sessions do
      get :finished, :on => :collection

      resources :applicants, controller: "session/applicants" do
        get :edit, :on => :collection
        put :select, :on => :member
        put :remove, :on => :member
        put :fix, :on => :collection
      end

    end
    resources :rooms do
      put :close, :on => :member
    end
    resources :characters
    resources :characters, as: :sword_world_rpg2
    resources :characters, as: :sword_world_rpg
  end

  resources :sessions, :only => :none do
    resources :rooms do
      put :close, :on => :member
    end
    resources :comments
  end

  resources :users, :only => :show do
    resources :characters, only: [:index, :show]
  end

  match "user", :controller => :users, :action => :info

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

  resources :game_systems

  resources :rooms do
    get :closed, :on => :collection
    put :close, :on => :member
  end
end
