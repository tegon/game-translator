GameTranslator::Application.routes.draw do

  root to: 'game_translator/games#edit_multiple'

  devise_for :users, class_name: 'GameTranslator::User', path_names: { 
    sign_in: 'login', sign_out: 'logout' 
    }, controllers: { 
      registrations: 'game_translator/registrations', 
      sessions: 'game_translator/sessions' 
      }
 
  get 'users' => 'game_translator/users#index', as: :user_index
  get 'users/new' => 'game_translator/users#new', as: :user_new
  post 'users/create' => 'game_translator/users#create', as: :user_create
  put 'users/:id' => 'game_translator/users#update', as: :user_update
  get 'users/:id/edit' => 'game_translator/users#edit', as: :user_edit
  delete 'users/:id' => 'game_translator/users#destroy', as: :user_destroy
  
  get 'games/translate' => 'game_translator/games#edit_multiple', as: :game_edit_multiple
  put 'games/translate/send' => 'game_translator/games#update_multiple', as: :game_update_multiple

  # The priority is based upon order of creation:
  # first created -> highest priority.
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
