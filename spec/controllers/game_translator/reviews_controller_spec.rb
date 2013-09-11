require 'spec_helper'

describe GameTranslator::ReviewsController do
  let(:reviser) { create(:game_translator_user, role: 'reviser') }
  let(:review) { create(:game_translator_review) }

  before { sign_in reviser }

  describe 'GET index' do
    it 'renders the reviews index' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET edit' do
    it 'renders the edit view' do
      p '/'*150
      p review.translations
      get :edit, id: review.id
      response.should render_template :edit
    end

    it 'assigns a review to the review variable' do
      get :edit, id: review.id
      assigns(:review).should == review
    end
  end

  describe 'PUT update' do
    context 'when accepted' do
      it 'redirects to the reviews index' do
        put :update, { id: review.id }
        response.should redirect_to review_path
      end

      it 'changes the review attributes' do
        put :update, { id: review.id }
        review.reload
        review.status.should == 'accepted'
        review.translations.map do |t|
          t.revised.should be_true
        end
      end
    end

    context 'when rejected' do
      it 'redirects to the reviews index' do
        put :update, { id: review.id, delete: 'Recusar' }
        response.should redirect_to review_path
      end

      it 'changes the review attributes' do
        put :update, { id: review.id, delete: 'Recusar' }
        review.reload
        review.status.should == 'rejected'
        review.translations.map do |t|
          t.revised.should be_true
          t.game.status.should == 'not_translated'
        end
      end
    end
  end
end