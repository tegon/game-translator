class GameTranslator::GamesController < ApplicationController
  load_and_authorize_resource

  def edit_multiple
    @languages = GameTranslator::Language.all
    @games = GameTranslator::Game.not_translated.random
    @games.map { |game| game.update_attribute(:status, 'translating') }
  end

  def update_multiple
    params['game'].keys.each do |id|
      @game = GameTranslator::Game.find(id.to_i)
      if @game.update_attributes(params['game'][id])

        @game.update_attribute(:status, 'translated')
        
        @game.translations.map do |t| 
          t.update_attribute(:user_id, params[:user_id]) unless t.locale == :'pt-BR'
        end

        flash[:sucess] = 'Game traduzido com sucesso!'
      else
        redirect_to game_edit_multiple_path
      end
    end
    redirect_to game_edit_multiple_path
  end
end