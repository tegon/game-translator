GameTranslator::Application.routes.draw do
  match '/' => 'game_translator/sessions#new'

  devise_for :user, class_name: "GameTranslator::User", path_names: { 
    sign_in: 'login', sign_out: 'logout' 
    }, controllers: { 
      registrations: 'game_translator/registrations', 
      sessions: 'game_translator/sessions' 
      }
  
  namespace :game_translator, path: 'game_translator' do 
    get 'user' => 'user#index', as: :user_index
    get 'user/new' => 'user#new', as: :user_new
    post 'user' => 'user#create', as: :user_create
    put 'user/:id' => 'user#update', as: :user_update
    get 'user/:id' => 'user#edit', as: :user_edit
    delete 'user/:id' => 'user#destroy', as: :user_destroy
  end

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
