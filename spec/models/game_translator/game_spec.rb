require 'spec_helper'

describe GameTranslator::Game do
  before do
    @game = create(:game_translator_game, status: 'translated')
    @not_translated = create(:game_translator_game, status: 'not_translated')
    @translating = create(:game_translator_game, status: 'translating')
  end 

  it 'should have a valid generator' do
    create(:game_translator_game).should be_valid
  end

  it 'should have many translations' do 
    @game.should respond_to :translations
  end

  describe 'status' do
    it 'should be present' do
      build(:game_translator_game, status: nil).should_not be_valid
      build(:game_translator_game, status: '').should_not be_valid
    end

    it 'should be valid' do
      build(:game_translator_game, status: 'foo').should_not be_valid
      build(:game_translator_game, status: 'translating').should be_valid
    end
  end

  describe 'translated scope' do 
    it 'should have scope for translated games' do
      GameTranslator::Game.should respond_to :translated
    end

    it 'should return only translated games' do
      translated = GameTranslator::Game.translated
      translated.should_not include @not_translated
      translated.should_not include @translating
      translated.should include @game
    end
  end

  describe 'not_translated scope' do 
    it 'should have a scope for not translated games' do 
      GameTranslator::Game.should respond_to :not_translated
    end

    it 'should return only not translated games' do
      not_translated = GameTranslator::Game.not_translated
      not_translated.should_not include @game
      not_translated.should_not include @translating
      not_translated.should include @not_translated
    end
  end

  it 'should have a random scope' do
    GameTranslator::Game.should respond_to :random
  end

  describe 'translated accessors' do
    before do
      I18n.locale = :"pt-BR"
      create(:game_translator_language, code: 'en')
      @game1 = create(:game_translator_game, name: 'game 1')
      @game1.update_attribute(:name_en, 'foo bar')
    end

    it 'should have translated accessors' do
      @game1.should respond_to :name_en
    end

    it 'should write name in en locale' do
      @game1.update_attribute(:name_en, 'foobarbaz')
      I18n.locale = :en
      @game1.name.should == 'foobarbaz'
    end

    it 'should read name in en locale' do
      @game1.name_en.should == 'foo bar'
    end

    it 'should read the name in actual locale' do
      @game1.name.should == 'game 1'
      I18n.locale = :en
      @game1.name.should == 'foo bar'
    end
  end
end