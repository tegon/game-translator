require 'spec_helper'

describe GameTranslator::Stat do
  let(:user) { create(:game_translator_user, role: 'translator') }
  let(:user2) { create(:game_translator_user, role: 'translator') }
  let(:accepted) { create(:game_translator_review, status: 'accepted') }
  let(:rejected) { create(:game_translator_review, status: 'rejected') }

  before do
    10.times { create(:game_translator_game, status: 'translated') }

    10.times { create(:game_translator_game, status: 'not_translated') }

    2.times { create(:game_translator_translation, revised: true, user: user2, review: rejected) }

    10.times { create(:game_translator_translation, revised: true, user: user, review: accepted) }

    5.times { create(:game_translator_translation, revised: false, user: user2) }
  end

  subject { GameTranslator::Stat }

  it { should respond_to :total }

  its(:total) { should == GameTranslator::Game.count }

  it { should respond_to :translated }

  its(:translated) { should == GameTranslator::Game.translated.count }

  it { should respond_to :revised }

  its(:revised) { should == GameTranslator::Translation.revised.count }

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

  its(:greatest_translator) { should == user }

  describe '.count_translations' do
    it { should respond_to :count_translations }

    it 'returns total of user translations' do
      GameTranslator::Stat.count_translations(user2).should == user2.translations.count
    end

    it 'returns total of accepted translations' do
      GameTranslator::Stat.count_translations(user, 'accepted').should == 10
    end

    it 'returns total of rejected translations' do
      GameTranslator::Stat.count_translations(user2, 'rejected').should == 2
    end
  end
end