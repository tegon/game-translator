require 'spec_helper'

describe GameTranslator::GamesController do
  before do
    @translator = create(:game_translator_user, role: 'translator')
    sign_in @translator

    create(:game_translator_language, code: 'en')

    10.times { create(:game_translator_game, status: 'not_translated') }

    @game1 = create(:game_translator_game, status: 'not_translated', name: 'bar')
    @game2 = create(:game_translator_game, status: 'not_translated')
    @game3 = create(:game_translator_game, status: 'not_translated')
    @game4 = create(:game_translator_game, status: 'not_translated')

    @params_game = {
      @game1.id.to_s => {
        name_en: 'foo'
      },

      @game2.id.to_s => {
        name_en: Faker::Name.name
      },

      @game3.id.to_s => {
        name_en: Faker::Name.name
      },

      @game4.id.to_s => {
        name_en: Faker::Name.name
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

  describe 'PUT update' do
    it 'redirects to the translate page' do
      put :update, { game: @params_game }
      response.should redirect_to game_translate_path
    end

    it 'changes the game attributes' do
      put :update, { game: @params_game }
      @game1.reload
      @game1.status.should == 'translated'
      @game1.translations.with_locale('en').map { |t| t.user_id.should == @translator.id }

      Globalize.with_locale('en') do
        @game1.name.should == 'foo'
      end

      @game1.name.should == 'bar'
    end
  end
end