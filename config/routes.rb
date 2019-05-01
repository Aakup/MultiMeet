# frozen_string_literal: true

Rails.application.routes.draw do
  # PROJECTS routes:
  ## PARTICIPANTS are copied from the ROSTER selected at project creation.
  ## RANKING is the time ranking selected by the specific participant.
  ## TIMES includes each datetime for the matching.
  ## MATCHING is the final matching.
  resources :projects do
    resources :participants do
      get 'display', on: :collection
      resource :ranking do
        get 'end', on: :collection
      end
    end
    resources :times
    resource :matching do
      post 'email', on: :collection
    end
  end

  # USERS routes: currently admins, may also include participants
  resources :users

  # ROSTERS routes: all rosters created by each user
  resources :rosters

  # Custom singular routes or reroutes
  post 'projects/:project_id/participants/display' => 'participants#email', :as => 'email_project_participants'
  delete 'projects/:project_id/times' => 'times#destroy_all', :as => 'destroy_project_times'
  post 'login' => 'sessions#create'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy', :as => 'logout'
  get 'signup' => 'users#new', :as => 'signup'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # resources :projects

  # You can have the root of your site routed with "root"
  root 'projects#index'

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
