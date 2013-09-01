class GameTranslator::GamesController < ApplicationController
  load_and_authorize_resource

  before_filter :check_games, only: :translate

  def translate
    @languages = GameTranslator::Language.all
    @games = GameTranslator::Game.not_translated.random
    @games.map { |game| game.update_attribute(:status, 'translating') }
    session[:translating] = @games.map { |game| game.id }
  end 

  def update
    params['game'].keys.each do |id|
      @game = GameTranslator::Game.find(id.to_i)
      if @game.update_attributes(params['game'][id])

        @game.update_attribute(:status, 'translated')
        
        set_user(@game.translations)

        flash[:sucess] = 'Game traduzido com sucesso!'
      else
        flash[:error] = 'Erro ao traduzir o game'
        @game.update_attribute(:status, 'not_translated')
      end
    end
    redirect_to game_translate_path
  end

  def idle
    check_games
  end

  private

  def check_games
    if session[:translating]
      session[:translating].each do |id|
        game = GameTranslator::Game.find(id)
        if game.status == 'translating'
          game.update_attribute(:status, 'not_translated')
        end
      end
    end
  end

  def set_user(translations)
    translations.with_locale(GameTranslator::Language.codes).map do |translation| 
      translation.update_attribute(:user_id, current_user.id)
    end
  end
end