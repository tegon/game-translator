GameTranslator::Application.routes.draw do
  scope "(:locale)", :locale => /en|es/ do
    root to: 'game_translator/games#translate'

    devise_for :users, skip: [:registrations], class_name: 'GameTranslator::User', path_names: {
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

    get 'review' => 'game_translator/reviews#index', as: :review
    get 'review/:id/edit' => 'game_translator/reviews#edit', as: :review_edit
    put 'review/:id' => 'game_translator/reviews#update', as: :review_update
    get 'review/:id' => 'game_translator/reviews#show', as: :review_show
    get 'review/:id/translation/:translation_id' => 'game_translator/reviews#translation', as: :review_translation

    get 'translate' => 'game_translator/games#translate', as: :game_translate
    put 'translate/update' => 'game_translator/games#update', as: :game_update

    get '/stats' => 'game_translator/stats#index', as: :stats
    get 'stats/users' => 'game_translator/stats#users_index', as: :stats_users_index
    get 'stats/user/:id' => 'game_translator/stats#user', as: :stats_user
    post 'stats/user/:id/per_date' => 'game_translator/stats#user_per_date', as: :stats_user_per_date

    get '/languages' => 'game_translator/languages#index', as: :languages
    post '/languages' => 'game_translator/languages#create', as: :language_create
    get '/languages/new' => 'game_translator/languages#new', as: :language_new
    get '/languages/:id/edit' => 'game_translator/languages#edit', as: :language_edit
    put '/languages/:id' => 'game_translator/languages#update', as: :language_update
    delete '/languages/:id' => 'game_translator/languages#destroy', as: :language_destroy
  end
end