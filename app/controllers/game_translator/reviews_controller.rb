class GameTranslator::ReviewsController < ApplicationController
  load_and_authorize_resource

  def index
    GameTranslator::Review.to_review
    @reviews = GameTranslator::Review.where(status: 'pending')
  end

  def edit
    @review = GameTranslator::Review.find(params[:id])
    @sample = @review.game_translations.sample
    @game = GameTranslator::Game.find(@sample.game_id)
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
    
    @review.game_translations.map do |t|
      t.update_attribute(:revised, true)
    end
    
    @review.update_attribute(:status, 'accepted')

    redirect_to review_path
  end

  def reject
    @review = GameTranslator::Review.find(params[:id])

    @review.game_translations.map do |t|
      t.update_attribute(:revised, true)
    end

    @review.update_attribute(:status, 'rejected')

    redirect_to review_path
  end
end