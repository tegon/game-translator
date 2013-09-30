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
  end

  describe 'POST user_per_date' do
    it 'returns json with translations per date' do
      post :user_per_date, id: @translator.id, date_from: '11/09/2013', date_to: '18/09/2013'
      json = JSON.parse(response.body)
      json['translations'].should == 0
      json['date_from'].should == '11/09/13'
      json['date_to'].should == '18/09/13'
    end
  end
end