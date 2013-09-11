require 'spec_helper'

describe GameTranslator::Stat do
  let(:user) { create(:game_translator_user, role: 'translator') }
  let(:user2) { create(:game_translator_user, role: 'translator') }

  before(:all) do
    10.times { create(:game_translator_game, status: 'translated') }

    10.times { create(:game_translator_game, status: 'not_translated') }

    10.times { create(:game_translator_game_translation, revised: true, user: user) }

    5.times { create(:game_translator_game_translation, revised: false, user: user2) }
  end

  subject { GameTranslator::Stat }

  it { should respond_to :total }

  its(:total) { should eq(GameTranslator::Game.count) }

  it { should respond_to :translated }

  its(:translated) { should eq(10) }

  it { should respond_to :revised }

  its(:revised) { should eq(10) }

  describe '.percentage' do
    it { should respond_to :percentage }

    it 'returns percentage of translated games' do
      total = GameTranslator::Game.count
      translated = GameTranslator::Game.translated.count
      percentage = (100 * translated/total.to_f).round
      GameTranslator::Stat.percentage.should == percentage
    end
  end

  it { should respond_to :greatest_translator }

  its(:greatest_translator) { should eq(user) }

  describe '.count_translations' do
    it { should respond_to :count_translations }

    it 'returns total of user translations' do
      GameTranslator::Stat.count_translations(user2).should == 5
    end
  end
end