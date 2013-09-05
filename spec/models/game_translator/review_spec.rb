require 'spec_helper'

describe GameTranslator::Review do
  it 'has a valid generator' do
    create(:game_translator_review).should be_valid
  end

  describe 'status' do
    it 'has an status' do
      build(:game_translator_review, status: nil).should_not be_valid
      build(:game_translator_review, status: '').should_not be_valid
    end

    it 'is a valid status' do
      build(:game_translator_review, status: 'foo').should_not be_valid
      build(:game_translator_review, status: %w(pending accepted rejected).sample).should be_valid
    end
  end

  describe '.to_review' do
    subject { GameTranslator::Review }

    it { should respond_to :to_review }

    let(:user) { create(:game_translator_user, role: 'translator') }

    context 'when user has at least 100 translations' do
      before do
        100.times { create(:game_translator_game_translation, user: user, revised: false) }
      end

      it 'creates review for user translations' do
        expect{ GameTranslator::Review.to_review }.to change{ GameTranslator::Review.count }.by(1)
      end
    end

    context 'when user has less than 100 translations' do
      before do
        10.times { create(:game_translator_game_translation, user: user, revised: false) }
      end

      it 'does not create review for user translations' do
        expect{ GameTranslator::Review.to_review }.to_not change{ GameTranslator::Review.count }.by(1)
      end
    end
  end
end