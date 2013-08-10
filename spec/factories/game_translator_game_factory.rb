FactoryGirl.define do
	factory :game_translator_game, class: GameTranslator::Game do
		name { Faker::Name.name }
		short_description { Faker::Lorem.sentence }
		long_description { Faker::Lorem.paragraphs.join }
		wide_description { Faker::Lorem.paragraph }
    instructions { Faker::Lorem.paragraph }
    status { %w(not_translated translated translating).sample }
	end
end