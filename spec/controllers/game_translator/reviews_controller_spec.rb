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

    context 'with filters' do
      let(:accepted) { create(:game_translator_review, status: 'accepted') }
      let(:rejected) { create(:game_translator_review, status: 'rejected') }
      let(:pending) { create(:game_translator_review, status: 'pending') }

      context 'when filter is accepted' do
        it 'renders the reviews index' do
          get :index, filter: 'accepted'
          response.should render_template :index
        end

        it 'displays accepted reviews' do
          get :index, filter: 'accepted'
          assigns(:reviews).should include accepted
        end

        it 'does not displays rejected, pending reviews' do
          get :index, filter: 'accepted'
          assigns(:reviews).should_not include rejected
          assigns(:reviews).should_not include pending
        end
      end

      context 'when filter is rejected' do
        it 'renders the reviews index' do
          get :index, filter: 'rejected'
          response.should render_template :index
        end

        it 'displays rejected reviews' do
          get :index, filter: 'rejected'
          assigns(:reviews).should include rejected
        end

        it 'does not displays accepted, pending reviews' do
          get :index, filter: 'rejected'
          assigns(:reviews).should_not include accepted
          assigns(:reviews).should_not include pending
        end
      end

      context 'when filter is pending' do
        it 'renders the reviews index' do
          get :index, filter: 'pending'
          response.should render_template :index
        end

        it 'displays pending reviews' do
          get :index, filter: 'pending'
          assigns(:reviews).should include pending
        end

        it 'does not displays accepted, rejected reviews' do
          get :index, filter: 'pending'
          assigns(:reviews).should_not include accepted
          assigns(:reviews).should_not include rejected
        end
      end
    end
  end

  describe 'GET edit' do
    it 'renders the edit view' do
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
        review.user.should == reviser
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
        review.user.should == reviser
        review.translations.map do |t|
          t.revised.should be_true
          t.game.status.should == 'not_translated'
        end
      end
    end
  end

  describe 'GET show' do
    it 'renders show template' do
      get :show, id: review.id
      response.should render_template :show
    end

    it 'assigns review' do
      get :show, id: review.id
      assigns(:review).should == review
    end

    it 'assigns review translations' do
      get :show, id: review.id
      translations = assigns(:translations).to_a
      translations.should == review.translations
    end
  end

  describe 'GET translation' do
    it 'renders translation template' do
      get :translation, { id: review.id, translation_id: review.translations.first.id }
      response.should render_template :translation
    end

    it 'assigns translation' do
      get :translation, { id: review.id, translation_id: review.translations.first.id }
      assigns(:translation).should == review.translations.first
    end

    it 'assigns translation game' do
      get :translation, { id: review.id, translation_id: review.translations.first.id }
      assigns(:game).should == review.translations.first.game
    end
  end
end