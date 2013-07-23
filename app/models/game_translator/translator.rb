module GameTranslator
	class Translator < ActiveRecord::Base
		# relations
		has_many :games
	end
end