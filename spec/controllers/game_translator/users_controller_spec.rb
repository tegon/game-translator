require 'spec_helper'

describe GameTranslator::UsersController do
  let(:reviser) { create(:game_translator_user, role: 'reviser') }
  let(:user) { create(:game_translator_user, name: 'Test') }

  before { sign_in reviser }

  it 'does not get a sign_up route' do
    expect { get '/users/sign_up' }.to raise_error(ActionController::RoutingError)
  end

  describe 'GET index' do
    it 'renders the users index' do
      sign_in reviser
      get :index
      response.should render_template :index
    end
  end

  describe 'GET new' do
    it 'assigns a new object to the user' do
      get :new
      assigns(:user).should be_new_record
    end

    it 'renders the new view' do
      get :new
      response.should render_template :new
    end
  end

  describe 'POST create' do
    it 'create user with valid attributes' do
      post :create, game_translator_user: attributes_for(:game_translator_user)
      response.should redirect_to user_index_path
    end

    it 'saves user to the database' do
      post :create, game_translator_user: attributes_for(:game_translator_user)
      assigns(:user).should_not be_new_record
      response.should redirect_to user_index_path
    end
  end

  describe 'GET edit' do
    it 'renders the edit view' do
      get :edit, id: user.id
      response.should render_template :edit
    end

    it 'assigns a user to the user variable' do
      get :edit, id: user.id
      assigns(:user).should == user
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      it 'redirects to the index view' do
        put :update, { id: user.id, game_translator_user: { name: 'John Doe' } }
        response.should redirect_to user_index_path
      end

      it 'changes the user attributes' do
        put :update, { id: user.id, game_translator_user: { name: 'Test Foo' } }
        user.reload
        user.name.should == 'Test Foo'
      end
    end

    context 'with invalid attributes' do
      it 'render the edit view' do
        put :update, { id: user.id, game_translator_user: { email: 'foo@' } }
        response.should render_template :edit
      end

      it 'does not changes the user attributes' do
        put :update, { id: user.id, game_translator_user: { email: 'foo@', name: 'Test Bar' } }
        user.reload
        user.name.should == 'Test'
      end
    end
  end


  describe 'DELETE destroy' do
    before { @translator = create(:game_translator_user, role: 'translator') }

    it 'redirects to the index page' do
      delete :destroy, id: @translator.id
      response.should redirect_to user_index_path
    end

    it 'deletes the user' do
      expect{ delete :destroy, id: @translator.id }.to change(GameTranslator::User, :count).by(-1)
    end
  end
end