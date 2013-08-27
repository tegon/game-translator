require 'spec_helper'

describe GameTranslator::ReviewsController do
  before do
    @reviser = create(:game_translator_user, role: 'reviser')
    sign_in @reviser

    @user = create(:game_translator_user, role: 'translator')
    @user2 = create(:game_translator_user, role: 'translator')

    100.times { create(:game_translator_game_translation, user: @user, revised: false) }
    GameTranslator::Review.to_review
    @review = GameTranslator::Review.all.sample
  end

  describe 'GET index' do
    it 'should render the reviews index' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET edit' do
    it 'should render the edit view' do
      get :edit, id: @review.id
      response.should render_template :edit
    end

    it 'should assigns a review to the review variable' do
      get :edit, id: @review.id
      assigns(:review).should == @review
    end
  end

  describe 'PUT update' do
    context 'when accepted' do
      it 'redirects to the reviews index' do
        put :update, { id: @review.id }
        response.should redirect_to review_path
      end

      it 'changes the review attributes' do
        put :update, { id: @review.id }
        @review.reload
        @review.status.should == 'accepted'
        @review.game_translations.map do |t|
          t.revised.should be_true
        end
      end
    end

    context 'when rejected' do
      it 'redirects to the reviews index' do
        put :update, { id: @review.id, delete: 'Recusar' }
        response.should redirect_to review_path
      end

      it 'changes the review attributes' do
        put :update, { id: @review.id, delete: 'Recusar' }
        @review.reload
        @review.status.should == 'rejected'
        @review.game_translations.map do |t|
          t.revised.should be_true
          t.game.status.should == 'not_translated'
        end
      end
    end
  end
end