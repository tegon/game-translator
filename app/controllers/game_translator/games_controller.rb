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
    @translations = get_translations.compact!
  end

  def get_translations
    GameTranslator::User.translators.map do |user|
      if user.game_translations.not_revised.count >= 100
        {
          user: user,
          ids: user.game_translations.not_revised.map { |t| t.id },
          sample: user.game_translations.not_revised.sample
        } 
      end
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
    if params[:delete_button]
      reject
      redirect_to review_path
    else
      @translations = params[:translations_ids]
      @translations.split(" ").map do |id|
        Translation.find(id).update_attribute(:revised, true)
      end
      redirect_to review_path
    end
  end
end