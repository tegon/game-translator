require 'spec_helper'

describe GameTranslator::Game::Translation do
  before do
    @translation = create(:game_translator_game_translation)
    @not_revised = create(:game_translator_game_translation, revised: false, review_id: nil)
  end

  it 'should have a valid generator' do
    create(:game_translator_game_translation).should be_valid
  end

  it 'should belongs to game' do
    @translation.should respond_to :game
  end

  it 'should belongs to user' do
    @translation.should respond_to :user
  end

  describe 'not_revised scope' do
    it 'should have a scope to not revised translations' do
      GameTranslator::Game::Translation.should respond_to :not_revised
    end

    it 'should return only not revised translations' do
      not_revised_translations = GameTranslator::Game::Translation.not_revised
      not_revised_translations.should_not include @translation
      not_revised_translations.should include @not_revised
    end
  end

  describe 'revised scope' do
    it 'should have a scope to revised translations' do
      GameTranslator::Game::Translation.should respond_to :revised
    end

    it 'should return only revised translations' do
      revised_translations = GameTranslator::Game::Translation.revised
      revised_translations.should_not include @not_revised
      revised_translations.should include @translation
    end
  end
end