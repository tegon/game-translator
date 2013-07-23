module GameTranslator
	class Translator < User
		# relationship
		has_many :games
	end
end