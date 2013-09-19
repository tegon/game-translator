# encoding: UTF-8
class GameTranslator::ReviewsController < ApplicationController
  load_and_authorize_resource

  def index
    GameTranslator::Review.to_review
    @reviews = GameTranslator::Review.paginate(page: params[:page])
  end

  def edit
    @review = GameTranslator::Review.find(params[:id])
    @sample = @review.translations.sample
    @game = @sample.game
  end

  def update
    if params[:delete]
      reject
    else
      accept
    end
  end

  def accept
    @review = GameTranslator::Review.find(params[:id])

    set_revised(@review.translations, 'accepted')

    @review.update_attributes(status: 'accepted', user: current_user)

    flash[:success] = 'Tradução aceita com sucesso!'

    redirect_to review_path
  end

  def reject
    @review = GameTranslator::Review.find(params[:id])

    set_revised(@review.translations, 'rejected')

    @review.update_attributes(status: 'rejected', user: current_user)

    flash[:success] = 'Tradução rejeitada com sucesso!'

    redirect_to review_path
  end

  def show
    @review = GameTranslator::Review.find(params[:id])
    @translations = @review.translations.paginate(page: params[:page])
  end

  def translation
    @translation = GameTranslator::Game::Translation.find(params[:translation_id])
    @game = @translation.game
  end

  private

  def set_revised(translations, status)
    translations.map do |translation|
      translation.update_attribute(:revised, true)
      translation.game.update_attribute(:status, 'not_translated') if status == 'rejected'
    end
  end
end