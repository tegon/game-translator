require 'spec_helper'

describe GameTranslator::Stat do
  before do
    10.times { create(:game_translator_game, status: 'translated') }

    10.times { create(:game_translator_game, status: 'not_translated') }

    10.times { create(:game_translator_game_translation, revised: true) }
  end

  describe '#total' do
    it 'should have a method for count games' do
      GameTranslator::Stat.should respond_to :total
    end

    it 'should return total of games' do
      GameTranslator::Stat.total.should == GameTranslator::Game.count
    end
  end

  describe '#translated' do
    it 'should have a method for count translated games' do
      GameTranslator::Stat.should respond_to :translated
    end

    it 'should return total of translated games' do
      GameTranslator::Stat.translated.should == GameTranslator::Game.translated.count
    end
  end

  describe '#revised' do
    it 'should have a method for count revised translations' do
      GameTranslator::Stat.should respond_to :revised
    end

    it 'should return total of revised translations' do
      GameTranslator::Stat.revised.should == Translation.revised.count
    end
  end

  describe '#percentage' do
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
end