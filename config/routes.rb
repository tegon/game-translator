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

  get '/languages' => 'game_translator/languages#index', as: :languages
  post '/languages' => 'game_translator/languages#create', as: :language_create
  get '/languages/new' => 'game_translator/languages#new', as: :language_new
  get '/languages/:id/edit' => 'game_translator/languages#edit', as: :language_edit
  put '/languages/:id' => 'game_translator/languages#update', as: :language_update
  delete '/languages/:id' => 'game_translator/languages#destroy', as: :language_destroy
end
