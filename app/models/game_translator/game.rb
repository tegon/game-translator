module GameTranslator
	class Game < ActiveRecord::Base
		has_many :translations
	end
end