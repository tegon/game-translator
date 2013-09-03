require 'spec_helper'

describe GameTranslator::UsersController do
  before do 
    @reviser = create(:game_translator_user, role: 'reviser')
    @translator = create(:game_translator_user, role: 'translator')
    @user = create(:game_translator_user, name: 'Test', password: '123123123', password_confirmation: '123123123')
  end

  it 'does not get a sign_up route' do
    expect { get '/users/sign_up' }.to raise_error(ActionController::RoutingError) 
  end

  describe 'GET index' do
    context 'when not logged in' do
      it 'redirect_tos login page' do
        get :index
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is reviser' do
      it 'renders the users index' do 
        sign_in @reviser
        get :index
        response.should render_template :index
      end
    end

    context 'when user is translator' do
      it 'redirects to translate games page' do
        sign_in @translator
        get :index
        response.should redirect_to game_translate_path
      end
    end
  end

  describe 'GET new' do
    context 'when not logged in' do
      it 'redirects to login page' do
        get :new
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is translator' do
      it 'redirects to translate games page' do
        sign_in @translator
        get :new
        response.should redirect_to game_translate_path
      end
    end

    context 'when user is reviser' do
      before do
        sign_in @reviser
      end

      it 'assigns a new object to the user' do
        get :new
        assigns(:user).should be_new_record
      end

      it 'renders the new view' do
        get :new 
        response.should render_template :new
      end
    end
  end

  describe 'POST create' do
    context 'when not logged in' do
      it 'redirects to login page' do
        put :create, game_translator_user: FactoryGirl.attributes_for(:game_translator_user)
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is translator' do
      it 'redirects to translate games page' do
        sign_in @translator
        post :create, game_translator_user: FactoryGirl.attributes_for(:game_translator_user)
        response.should redirect_to game_translate_path
      end
    end

    context 'when user is reviser' do
      before do
        sign_in @reviser
      end

      it 'create user with valid attributes' do 
        post :create, game_translator_user: FactoryGirl.attributes_for(:game_translator_user)
        response.should redirect_to user_index_path
      end

      it 'saves user to the database' do
        post :create, game_translator_user: FactoryGirl.attributes_for(:game_translator_user)
        assigns(:user).should_not be_new_record
        response.should redirect_to user_index_path
      end
    end
  end

  describe 'GET edit' do
    context 'when not logged in' do
      it 'redirects to login page' do
        get :edit, id: @translator.id
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is translator' do
      it 'redirects to translate games page' do
        sign_in @translator
        get :edit, id: @translator.id
        response.should redirect_to game_translate_path
      end
    end

    context 'when user is reviser' do
      before do 
        sign_in @reviser
      end

      it 'renders the edit view' do
        get :edit, id: @translator.id
        response.should render_template :edit
      end

      it 'assignses a user to the user variable' do
        get :edit, id: @translator.id
        assigns(:user).should == @translator
      end
    end
  end

  describe 'PUT update' do
    before do
      sign_in @reviser
    end

    context 'with valid attributes' do
      it 'redirects to the index view' do
        put :update, { id: @user.id, game_translator_user: { name: 'John Doe' } }
        response.should redirect_to user_index_path
      end

      it 'changes the user attributes' do
        put :update, { id: @user.id, game_translator_user: { name: 'Test Foo' } }
        @user.reload
        @user.name.should == 'Test Foo'
      end
    end
  
    context 'with invalid attributes' do
      it 'render the edit view' do
        put :update, { id: @user.id, game_translator_user: { email: 'foo@' } }
        response.should render_template :edit
      end

      it 'not changes the user attributes' do 
        put :update, { id: @user.id, game_translator_user: { email: 'foo@', name: 'Test Bar' } }
        @user.reload
        @user.name.should == 'Test'
      end
    end
  end


  describe 'DELETE destroy' do
    before do
      sign_in @reviser
    end

    it 'redirects to the index page' do
      delete :destroy, id: @user.id
      response.should redirect_to user_index_path
    end

    it 'deletes the user' do
      expect{ delete :destroy, id: @user.id }.to change(GameTranslator::User, :count).by(-1)
    end
  end  
end
