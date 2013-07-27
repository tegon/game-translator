module GameTranslator
	class Language < ActiveRecord::Base
		attr_accessible :abbreviation, :name
	end
end