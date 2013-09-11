FactoryGirl.define do
  factory :game_translator_review, class: GameTranslator::Review do
    status { %w(pending accepted rejected).sample }
    user { create(:game_translator_user) }
    translations { translations_create }
  end
end

def translations_create
  [create(:game_translator_game_translation)]
end