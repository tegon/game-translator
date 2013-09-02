require 'spec_helper'

describe GameTranslator::Stat do
  before do
    @user = create(:game_translator_user, role: 'translator')
    @user2 = create(:game_translator_user, role: 'translator')

    10.times { create(:game_translator_game, status: 'translated') }

    10.times { create(:game_translator_game, status: 'not_translated') }

    10.times { create(:game_translator_game_translation, revised: true, user_id: @user.id) }

    5.times { create(:game_translator_game_translation, user_id: @user2.id) }
  end

  describe '.total' do
    it 'should have a method for count games' do
      GameTranslator::Stat.should respond_to :total
    end

    it 'should return total of games' do
      GameTranslator::Stat.total.should == GameTranslator::Game.count
    end
  end

  describe '.translated' do
    it 'should have a method for count translated games' do
      GameTranslator::Stat.should respond_to :translated
    end

    it 'should return total of translated games' do
      GameTranslator::Stat.translated.should == GameTranslator::Game.translated.count
    end
  end

  describe '.revised' do
    it 'should have a method for count revised translations' do
      GameTranslator::Stat.should respond_to :revised
    end

    it 'should return total of revised translations' do
      GameTranslator::Stat.revised.should == Translation.revised.count
    end
  end

  describe '.percentage' do
    it 'should have a method for percentage of translated games' do
      GameTranslator::Stat.should respond_to :percentage
    end

    it 'should return percentage of translated games' do
      total = GameTranslator::Game.count
      translated = GameTranslator::Game.translated.count
      percentage = (100 * translated/total.to_f).round
      GameTranslator::Stat.percentage.should == percentage
    end
  end

  describe '.greatest_translator' do
    it 'should have a method for get the greatest translator' do
      GameTranslator::Stat.should respond_to :greatest_translator
    end

    it 'should return the user with more translations' do
      GameTranslator::Stat.greatest_translator.should == @user
    end
  end

  describe '.count_translations' do
    it 'should have a method for count user translations' do
      GameTranslator::Stat.should respond_to :count_translations
    end

    it 'should return total of user translations' do
      GameTranslator::Stat.count_translations(@user2).should == 5
    end
  end
end