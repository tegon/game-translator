FactoryGirl.define do
	factory :game_translator_user, class: GameTranslator::User do
		name { Faker::Name.name }
		email { Faker::Internet.email }
		password { '123123123' }
		password_confirmation { '123123123' }
		role { %w(translator reviser).sample }
	end
end