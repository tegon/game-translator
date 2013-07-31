class GameTranslator::GamesController < ApplicationController
  load_and_authorize_resource only: [:edit_multiple, :update_multiple]

  def edit_multiple
    @languages = GameTranslator::Language.languages_abbreviations
    @games = GameTranslator::Game.not_translated.random
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

  def review
    authorize! :review, current_user
    GameTranslator::User.where(role: 'translator').map do |user|
      @translations = Translation.where(user_id: user.id).not_revised
      if @translations.count >=  100
        @translation = @translations.sample 
        @game = Game.find(@translation.game.id)
      end
    end
  end

  def reject
    authorize! :review, current_user
    Translation.destroy_all(user_id: params[:id])
    redirect_to review_path
  end

  def accept
    @translations = Translation.where(user_id: params[:id]).not_revised
    @translations.map do |translation|
      translation.update_attribute(:revised, true)
    end
    redirect_to review_path
  end
end