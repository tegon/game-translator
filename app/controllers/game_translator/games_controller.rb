class GameTranslator::GamesController < ApplicationController
  load_and_authorize_resource

  def translate
    @languages = GameTranslator::Language.all
    @games = GameTranslator::Game.not_translated.random
    @games.map { |game| game.update_attribute(:status, 'translating') }
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

  def stop_translation
    @games = params[:games]
    @games.each do |game|
      Game.find(game).update_attribute(:status, 'not_translated')
    end
  end

  def idle
  end

  private

  def set_user(translations)
    translations.with_locale(GameTranslator::Language.codes).map do |translation| 
      translation.update_attribute(:user_id, current_user.id)
    end
  end
end