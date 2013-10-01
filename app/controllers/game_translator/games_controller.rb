class GameTranslator::GamesController < ApplicationController
  load_and_authorize_resource

  before_filter :check_games, only: :translate

  def translate
    @languages = GameTranslator::Language.codes
    @game = GameTranslator::Game.not_translated.sample
    @game.update_attribute(:status, 'translating')
    session[:translating] = @game.id
  end

  def update
    @game = GameTranslator::Game.find(params[:id])
    if @game.update_attributes(params['game'].merge(status: 'translated'))
      set_user(@game.translations)
      flash[:sucess] = t('controllers.games.update.success')
    else
      flash[:error] = t('controllers.games.update.error')
      @game.update_attribute(:status, 'not_translated')
    end
    redirect_to game_translate_path
  end

  private

  def check_games
    if session[:translating]
      game = GameTranslator::Game.find(session[:translating])
      if game.status == 'translating'
        game.update_attribute(:status, 'not_translated')
      end
    end
  end

  def set_user(translations)
    translations.with_locale(GameTranslator::Language.codes).map do |translation|
      translation.update_attribute(:user, current_user)
    end
  end
end