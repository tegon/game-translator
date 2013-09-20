FactoryGirl.define do
  factory :game_translator_translation, class: GameTranslator::Translation do
    game { create(:game_translator_game) }
    user { create(:game_translator_user) }
    revised { true }
    locale { 'en' }
    name { Faker::Name.name }
    short_description { Faker::Lorem.sentence }
    long_description { Faker::Lorem.paragraphs.join }
    wide_description { Faker::Lorem.paragraph }
    instructions { Faker::Lorem.paragraph }
  end
end