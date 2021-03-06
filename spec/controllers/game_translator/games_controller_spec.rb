require 'spec_helper'

describe GameTranslator::GamesController do
  let(:translator) { create(:game_translator_user, role: 'translator') }

  let(:game1) { create(:game_translator_game, status: 'not_translated', name: 'bar') }
  let(:game2) { create(:game_translator_game, status: 'not_translated') }
  let(:game3) { create(:game_translator_game, status: 'not_translated') }
  let(:game4) { create(:game_translator_game, status: 'not_translated') }

  before do
    I18n.locale = :"pt-BR"

    sign_in translator

    create(:game_translator_language, code: 'en')

    10.times { create(:game_translator_game, status: 'not_translated') }

    @params_game = {
      game1.id.to_s => {
        name_en: 'foo', short_description_en: Faker::Lorem.sentence,
        long_description_en: Faker::Lorem.paragraphs.join, instructions_en: Faker::Lorem.paragraph
      },

      game2.id.to_s => {
        name_en: Faker::Name.name, short_description_en: Faker::Lorem.sentence,
        long_description_en: Faker::Lorem.paragraphs.join, instructions_en: Faker::Lorem.paragraph
      },

      game3.id.to_s => {
        name_en: Faker::Name.name, short_description_en: Faker::Lorem.sentence,
        long_description_en: Faker::Lorem.paragraphs.join, instructions_en: Faker::Lorem.paragraph
      },

      game4.id.to_s => {
        name_en: Faker::Name.name, short_description_en: Faker::Lorem.sentence,
        long_description_en: Faker::Lorem.paragraphs.join, instructions_en: Faker::Lorem.paragraph
      }
    }
  end

  describe 'GET translate' do
    it 'renders the edit view' do
      get :translate
      response.should render_template :translate
    end

    it 'changes games status' do
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
      game1.reload
      game1.status.should == 'translated'
      game1.translations.with_locale('en').map { |t| t.user.should == translator }
      game1.name.should == 'bar'
      I18n.locale = :en
      game1.name.should == 'foo'
    end
  end
end