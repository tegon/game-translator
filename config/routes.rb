GameTranslator::Application.routes.draw do
  root to: 'game_translator/games#edit'

  devise_for :user, class_name: 'GameTranslator::User', path_names: { 
    sign_in: 'login', sign_out: 'logout' 
    }, controllers: { 
      registrations: 'game_translator/registrations', 
      sessions: 'game_translator/sessions' 
      }
 
  get 'user' => 'game_translator/user#index', as: :user_index
  get 'user/new' => 'game_translator/user#new', as: :user_new
  post 'user/create' => 'game_translator/user#create', as: :user_create
  put 'user/:id' => 'game_translator/user#update', as: :user_update
  get 'user/:id/edit' => 'game_translator/user#edit', as: :user_edit
  delete 'user/:id' => 'game_translator/user#destroy', as: :user_destroy
  
  # resources :games, controller: 'game_translator/games'
  # get '/games/:id' => 'game_translator/games#edit', as: :game_edit
  # get '/games/' => 'game_translator/games#index', as: :game_index
  # put '/games/:id' => 'game_translator/games#update', as: :game_update
  get 'games/edit_multiple' => 'game_translator/games#edit_multiple', as: :game_edit_multiple
  put 'games/update_multiple' => 'game_translator/games#update_multiple', as: :game_update_multiple

  match 'translate/:id' => 'translations#edit'
  match 'translate/send/:id' => 'translations#update'
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
