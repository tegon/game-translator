require 'spec_helper'

describe GameTranslator::Game::Translation do
  let(:translation) { create(:game_translator_game_translation) }

  it 'has a valid generator' do
    create(:game_translator_game_translation).should be_valid
  end

  it { should respond_to :game }

  it { should respond_to :user }

  it 'updates user' do
    user = create(:game_translator_user)
    translation.update_attribute(:user, user)
    translation.user.should eql(user)
  end

  it { should respond_to :review }

  it 'updates review' do
    review = create(:game_translator_review)
    translation.update_attribute(:review, review)
    translation.review.should eql(review)
  end

  context 'scopes' do
    subject { GameTranslator::Game::Translation }

    before do
      @translation = create(:game_translator_game_translation)
      @not_revised = create(:game_translator_game_translation, revised: false, review_id: nil)
    end

    it { should respond_to(:of_date) }

    describe 'not_revised scope' do
      it { should respond_to :not_revised }

      it 'returns only not revised translations' do
        not_revised_translations = GameTranslator::Game::Translation.not_revised
        not_revised_translations.should_not include @translation
        not_revised_translations.should include @not_revised
      end
    end

    describe 'revised scope' do
      it { should respond_to :revised }

      it 'returns only revised translations' do
        revised_translations = GameTranslator::Game::Translation.revised
        revised_translations.should_not include @not_revised
        revised_translations.should include @translation
      end
    end
  end
end