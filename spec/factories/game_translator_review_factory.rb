FactoryGirl.define do
  factory :game_translator_review, class: GameTranslator::Review do
    status { %w(pending accepted rejected).sample }
    user { create(:game_translator_user) }
  end
end