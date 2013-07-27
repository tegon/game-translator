class GameTranslator::GamesController < ApplicationController
  load_and_authorize_resource

  def edit_multiple
    @languages = GameTranslator::Language.languages_abbreviations
    GameTranslator::Game.transaction do
      @games = GameTranslator::Game.lock(true).not_translated.random
    end

  rescue Exception => e
    flash[:notice] = 'Erro: #{ e }'
    false
  end

  def update_multiple
    params['game'].keys.each do |id|
      @game = GameTranslator::Game.find(id.to_i)
      if @game.update_attributes(params['game'][id])
        @game.update_attribute(:translated, true)
        flash[:sucess] = 'Game traduzido com sucesso!'
      else
        redirect_to game_edit_multiple_path
      end
    end
    redirect_to game_edit_multiple_path
  end
end