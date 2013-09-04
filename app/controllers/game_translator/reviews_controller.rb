# encoding: UTF-8
class GameTranslator::ReviewsController < ApplicationController
  load_and_authorize_resource

  def index
    GameTranslator::Review.to_review
    @reviews = GameTranslator::Review.where(status: 'pending').paginate(page: params[:page])
  end

  def edit
    @review = GameTranslator::Review.find(params[:id])
    @sample = @review.games.sample
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

    set_revised(@review.games, 'accepted')

    @review.update_attribute(:status, 'accepted')

    flash[:success] = 'Tradução aceita com sucesso!'

    redirect_to review_path
  end

  def reject
    @review = GameTranslator::Review.find(params[:id])

    set_revised(@review.games, 'rejected')

    @review.update_attribute(:status, 'rejected')

    flash[:success] = 'Tradução rejeitada com sucesso!'

    redirect_to review_path
  end

  private

  def set_revised(games, status)
    games.map do |game|
      game.update_attribute(:revised, true)
      game.game.update_attribute(:status, 'not_translated') if status == 'rejected'
    end
  end
end