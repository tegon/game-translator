require 'spec_helper'

describe GameTranslator::Game do
  it 'has a valid generator' do
    create(:game_translator_game).should be_valid
  end

  it { should respond_to :translations }

  describe 'status' do
    it 'is present' do
      build(:game_translator_game, status: nil).should_not be_valid
      build(:game_translator_game, status: '').should_not be_valid
    end

    it 'is valid' do
      build(:game_translator_game, status: 'foo').should_not be_valid
      build(:game_translator_game, status: 'translating').should be_valid
    end
  end

  describe 'scopes' do
    before do
      @translated = create(:game_translator_game, status: 'translated')
      @not_translated = create(:game_translator_game, status: 'not_translated')
      @translating = create(:game_translator_game, status: 'translating')
    end

    it 'has scope for translated games' do
      GameTranslator::Game.should respond_to :translated
    end

    it 'returns only translated games' do
      translated = GameTranslator::Game.translated
      translated.should_not include @not_translated
      translated.should_not include @translating
      translated.should include @translated
    end

    it 'has a scope for not translated games' do
      GameTranslator::Game.should respond_to :not_translated
    end

    it 'returns only not translated games' do
      not_translated = GameTranslator::Game.not_translated
      not_translated.should_not include @translated
      not_translated.should_not include @translating
      not_translated.should include @not_translated
    end
  end

  it 'has a random scope' do
    GameTranslator::Game.should respond_to :random
  end

  describe 'translated accessors' do
    before do
      I18n.locale = :"pt-BR"
      create(:game_translator_language, code: 'en')
      @game = create(:game_translator_game, name: 'game 1')
      @game.update_attribute(:name_en, 'foo bar')
    end

    it 'has translated accessors' do
      @game.should respond_to :name_en
    end

    it 'writes name in en locale' do
      @game.update_attribute(:name_en, 'foobarbaz')
      I18n.locale = :en
      @game.name.should == 'foobarbaz'
    end

    it 'reads name in en locale' do
      @game.name_en.should == 'foo bar'
    end

    it 'reads name in actual locale' do
      @game.name.should == 'game 1'
      I18n.locale = :en
      @game.name.should == 'foo bar'
    end
  end
end