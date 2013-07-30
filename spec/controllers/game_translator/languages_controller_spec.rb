require 'spec_helper'

describe GameTranslator::LanguagesController do
  before do 
    @reviser = create(:game_translator_user, role: 'reviser')
    @translator = create(:game_translator_user, role: 'translator')
    @language = create(:game_translator_language, name: 'Language', abbreviation: 'te')
  end

  describe 'GET index' do
    context 'when not logged in' do
      it 'should redirect_to login page' do
        get :index
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is reviser' do
      it 'should render the users index' do 
        sign_in @reviser
        get :index
        response.should render_template :index
      end
    end

    context 'when user is translator' do
      it 'should redirect to games/translate' do
        sign_in @translator
        get :index
        response.should redirect_to game_edit_multiple_path
      end
    end
  end

  describe 'GET new' do
    context 'when not logged in' do
      it 'should redirect to login page' do
        get :new
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is translator' do
      it 'should redirect to games/translate' do
        sign_in @translator
        get :new
        response.should redirect_to game_edit_multiple_path
      end
    end

    context 'when user is reviser' do
      before do
        sign_in @reviser
      end

      it 'assigns a new object to the language' do
        get :new
        assigns(:language).should be_new_record
      end

      it 'renders the new view' do
        get :new 
        response.should render_template :new
      end
    end
  end

  describe 'POST create' do
    context 'when not logged in' do
      it 'should redirect to login page' do
        put :create, game_translator_language: FactoryGirl.attributes_for(:game_translator_language)
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is translator' do
      it 'should redirect to games/translate' do
        sign_in @translator
        post :create, game_translator_language: FactoryGirl.attributes_for(:game_translator_language)
        response.should redirect_to game_edit_multiple_path
      end
    end

    context 'when user is reviser' do
      before do
        sign_in @reviser
      end

      it 'create language with valid attributes' do 
        post :create, game_translator_language: FactoryGirl.attributes_for(:game_translator_language)
        response.should redirect_to languages_path
      end

      it 'saves language to the database' do
        post :create, game_translator_language: FactoryGirl.attributes_for(:game_translator_language)
        assigns(:language).should_not be_new_record
        response.should redirect_to languages_path
      end
    end
  end

  describe 'GET edit' do
    context 'when not logged in' do
      it 'should redirect to login page' do
        get :edit, id: @language.id
        response.should redirect_to new_user_session_path
      end
    end

    context 'when user is translator' do
      it 'should redirect to games/translate' do
        sign_in @translator
        get :edit, id: @language.id
        response.should redirect_to game_edit_multiple_path
      end
    end

    context 'when user is reviser' do
      before do 
        sign_in @reviser
      end

      it 'should render the edit view' do
        get :edit, id: @language.id
        response.should render_template :edit
      end

      it 'should assigns a language to the language variable' do
        get :edit, id: @language.id
        assigns(:language).should == @language
      end
    end
  end

  describe 'PUT update' do
    before do
      sign_in @reviser
    end

    context 'with valid attributes' do
      it 'redirects to the index view' do
        put :update, { id: @language.id, game_translator_language: { abbreviation: 'te-st' } }
        response.should redirect_to languages_path
      end

      it 'changes the language attributes' do
        put :update, { id: @language.id, game_translator_language: { abbreviation: 'st-te' } }
        @language.reload
        @language.abbreviation.should == 'st-te'
      end
    end
  
    context 'with invalid attributes' do
      it 'render the edit view' do
        put :update, { id: @language.id, game_translator_language: { abbreviation: 'abcdef' } }
        response.should render_template :edit
      end

      it 'not changes the language attributes' do 
        put :update, { id: @language.id, game_translator_language: { abbreviation: 'abcdef', name: 'Language2' } }
        @language.reload
        @language.name.should == 'Language'
      end
    end
  end


  describe 'DELETE destroy' do
    before do
      sign_in @reviser
    end

    it 'redirects to the index page' do
      delete :destroy, id: @language.id
      response.should redirect_to languages_path
    end

    it 'deletes the language' do
      expect{ delete :destroy, id: @language.id }.to change(GameTranslator::Language, :count).by(-1)
    end
  end  
end