require 'spec_helper'

describe GameTranslator::GamesController do
  let(:translator) { create(:game_translator_user, role: 'translator') }

  before do
    I18n.locale = :"pt-BR"
    sign_in translator
    @game = create(:game_translator_game, status: 'not_translated', name: 'bar')
    create(:game_translator_language, code: 'en')
    @params_game = {
      name_en: 'foo', short_description_en: Faker::Lorem.sentence,
      long_description_en: Faker::Lorem.paragraphs.join, instructions_en: Faker::Lorem.paragraph
    }
  end

  describe 'GET translate' do
    it 'renders the edit view' do
      get :translate
      response.should render_template :translate
    end

    it 'changes games status' do
      get :translate
      assigns(:game).status.should == 'translating'
    end
  end

  describe 'PUT update' do
    it 'redirects to the translate page' do
      put :update, { id: @game.id, game: @params_game }
      response.should redirect_to game_translate_path
    end

    it 'changes the game attributes' do
      put :update, { id: @game.id, game: @params_game }
      @game.reload
      @game.status.should == 'translated'
      @game.translations.with_locale('en').map { |t| t.user.should == translator }
      @game.name.should == 'bar'
      I18n.locale = :en
      @game.name.should == 'foo'
    end
  end
end