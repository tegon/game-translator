require 'spec_helper'

describe GameTranslator::Review do
  it 'should have a valid generator' do
    create(:game_translator_review).should be_valid
  end

  describe 'status' do
    it 'should have an status' do
      build(:game_translator_review, status: nil).should_not be_valid
      build(:game_translator_review, status: '').should_not be_valid
    end

    it 'should be a valid status' do
      build(:game_translator_review, status: 'foo').should_not be_valid
      build(:game_translator_review, status: %w(pending accepted rejected).sample).should be_valid
    end
  end

  describe '#to_review' do
    it 'should have a method to create reviews' do
      GameTranslator::Review.should respond_to :to_review
    end

    context 'when user has at least 100 translations' do
      before do
        @user = create(:game_translator_user, role: 'translator')
        100.times { create(:game_translator_game_translation, user: @user, revised: false) }
      end

      it 'should create review for user translations' do
        expect{ GameTranslator::Review.to_review }.to change{ GameTranslator::Review.count }.by(1)
      end
    end

    context 'when user has less than 100 translations' do
      before do
        @user = create(:game_translator_user, role: 'translator')
        10.times { create(:game_translator_game_translation, user: @user, revised: false) }
      end

      it 'should not create review for user translations' do
        expect{ GameTranslator::Review.to_review }.to_not change{ GameTranslator::Review.count }.by(1)
      end
    end
  end
end