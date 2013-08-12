require 'spec_helper'

describe GameTranslator::GamesController do
  before do
    @translator = create(:game_translator_user, role: 'translator')
    @translator2 = create(:game_translator_user, role: 'translator')
    sign_in @translator

    create(:game_translator_language, abbreviation: 'en')

    10.times { create(:game_translator_game, status: 'not_translated') }

    @game1 = create(:game_translator_game, status: 'not_translated')
    @game2 = create(:game_translator_game, status: 'not_translated')
    @game3 = create(:game_translator_game, status: 'not_translated')
    @game4 = create(:game_translator_game, status: 'not_translated')
    @games = @game1, @game2, @game3, @game4

    @params_game = {
      @game1.id.to_s => {
        name: @game1.name
      },

      @game2.id.to_s => {
        name: @game2.name
      },

      @game3.id.to_s => {
        name: @game3.name
      },

      @game4.id.to_s => {
        name: @game4.name
      }
    }
  end

  describe 'GET translate' do
    it 'should render the edit view' do
      get :translate
      response.should render_template :translate
    end

    it 'should should change games status' do
      get :translate
      assigns(:games).each { |game| game.status.should == 'translating' }
    end
  end

  describe 'PUT translate_update' do
    it 'redirects to the translate page' do
      put :translate_update, { user_id: @translator.id, game: @params_game }
      response.should redirect_to game_translate_path
    end

    it 'changes the game attributes' do
      put :translate_update, { user_id: @translator.id, game: @params_game }
      @game1.reload
      @game1.status.should == 'translated'
    end
  end
end