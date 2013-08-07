FactoryGirl.define do
  factory :game_translator_game_translation, class: GameTranslator::GameTranslation do
    game_id { 1 }
    user_id { 1 }
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