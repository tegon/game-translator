GameTranslator::Application.routes.draw do
  devise_for :users, :class_name => "GameTranslator::User"

  # The priority is based upon order of creation:
  # first created -> highest priority.
  match 'translate/:id' => 'translations#edit'
  # Sample of regular route:
  #   match 'games/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'games/:id/purchase' => 'catalog#purchase', as: :purchase
  # This route can be invoked with purchase_url(id: game.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :games

  # Sample resource route with options:
  #   resources :games do
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
  #   resources :games do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :games do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/games/* to Admin::gamesController
  #     # (app/controllers/admin/games_controller.rb)
  #     resources :games
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root to: 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
