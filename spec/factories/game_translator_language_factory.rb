FactoryGirl.define do
	factory :game_translator_language, class: GameTranslator::Language do
		name { Faker::Name.name }
		code { I18n.available_locales.sample.to_s }
	end
end