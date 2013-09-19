require 'spec_helper'

describe GameTranslator::StatsController do
  before do
    @translator = create(:game_translator_user, role: 'translator')
    @reviser = create(:game_translator_user, role: 'reviser')
    sign_in @reviser
  end

  describe 'GET index' do
    it 'renders the stats index' do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET users index' do
    it 'renders the users stats index' do
      get :users_index
      response.should render_template :users_index
    end

    it 'does not displays revisers' do
      get :users_index
      assigns(:users).should_not include @reviser
    end

    it 'displays translators' do
      get :users_index
      assigns(:users).should include @translator
    end
  end

  describe 'GET user' do
    it 'renders the user stats' do
      get :user, id: @translator.id
      response.should render_template :user
    end

    it 'accepts dates params' do
      get :user, id: @translator.id, date_from: '11/09/2013', date_to: '18/09/2013'
      response.should render_template :user
    end
  end
end