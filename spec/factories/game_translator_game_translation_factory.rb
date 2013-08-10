FactoryGirl.define do
  factory :game_translator_game_translation, class: GameTranslator::GameTranslation do
    game { create(:game_translator_game) }
    user { create(:game_translator_user) }
    revised { true }
    rejected { false }
    locale { 'en' }
    name { Faker::Name.name }
    short_description { Faker::Lorem.sentence }
    long_description { Faker::Lorem.paragraphs.join }
    wide_description { Faker::Lorem.paragraph }
    instructions { Faker::Lorem.paragraph }
  end
end