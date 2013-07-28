FactoryGirl.define do
	factory :game_translator_language, class: GameTranslator::Language do
		name { Faker::Name.name }
		abbreviation { 'de' }
	end
end