require 'spec_helper'

describe GameTranslator::Review do
  subject { GameTranslator::Review }

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

  describe 'pending?' do
    context 'when status is pending' do
      subject { create(:game_translator_review, status: 'pending') }

      it { should respond_to :pending? }

      it { should be_pending }
    end

    context 'when status is not pending' do
      subject { create(:game_translator_review, status: %w(rejected accepted).sample) }

      it { should_not be_pending }
    end
  end

  describe 'status scopes' do
    let(:accepted) { create(:game_translator_review, status: 'accepted') }
    let(:rejected) { create(:game_translator_review, status: 'rejected') }
    let(:pending) { create(:game_translator_review, status: 'pending') }

    describe 'accepted scope' do
      it { should respond_to :accepted }

      its(:accepted) { should include accepted }

      its(:accepted) { should_not include rejected }

      its(:accepted) { should_not include pending }
    end

    describe 'rejected scope' do
      it { should respond_to :rejected }

      its(:rejected) { should include rejected }

      its(:rejected) { should_not include accepted }

      its(:rejected) { should_not include pending }
    end

    describe 'pending scope' do
      it { should respond_to :pending }

      its(:pending) { should include pending }

      its(:pending) { should_not include accepted }

      its(:pending) { should_not include rejected }
    end
  end
end