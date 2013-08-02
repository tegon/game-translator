class GameTranslator::GamesController < ApplicationController
  load_and_authorize_resource only: [:edit_multiple, :update_multiple]

  def edit_multiple
    @languages = GameTranslator::Language.abbreviations
    @games = GameTranslator::Game.not_translated.random
  end

  def update_multiple
    params['game'].keys.each do |id|
      @game = GameTranslator::Game.find(id.to_i)
      if @game.update_attributes(params['game'][id])

        @game.update_attribute(:translated, true)
        
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

  def review
    authorize! :review, current_user
    @translations = Translation.to_review.compact!
  end

  def review_confirm
    authorize! :review, current_user
    if params[:delete]
      reject
    else
      accept
    end
  end

  def reject
    authorize! :review, current_user
    @translations = params[:translations_ids]

    @translations.split(" ").map do |id|
      t = Translation.find(id)
      t.game.update_attribute(:translated, false)
      t.update_attributes(rejected: true, revised: true)
    end
    
    redirect_to review_path
  end

  def accept
    authorize! :review, current_user
    @translations = params[:translations_ids]

    @translations.split(" ").map do |id|
      Translation.find(id).update_attribute(:revised, true)
    end
    
    redirect_to review_path
  end
end