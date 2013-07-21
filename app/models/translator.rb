module GameTranslator
	class Translator < ActiveRecord::Base
		has_many :translations
	end
end