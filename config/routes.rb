Rails.application.routes.draw do

  resources :boards do
    resources :initiatives
    resources :teams
    resources :roles
    resources :projects
    resources :locations
    resources :people do
      collection do
        get :autocomplete
      end
    end
    get 'changelog'
    get 'allocation'
    get 'completed'
    get 'todo'
    post 'send_reminders'
    get 'search', to: 'search#search'
    get 'search/index', to: 'search#index'

  end

  resources :initiatives do
    resources :projects
  end

  resources :projects do
    resources :project_members
  end

  resources :people do
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get 'home/index'

  get 'sessions/create'

  get '/auth/:provider/callback', to: 'sessions#create'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  authenticated :user do
    devise_scope :user do
      root to: "boards#index"
    end
  end

  unauthenticated do
    devise_scope :user do
      root to: "home#index", :as => "unauthenticated"
    end
  end
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
