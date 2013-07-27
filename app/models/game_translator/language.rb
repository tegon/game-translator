module GameTranslator
	class Language < ActiveRecord::Base
		attr_accessible :abbreviation, :name

		def self.languages_abbreviations
			GameTranslator::Language.all.map { |l| l.abbreviation }
		end
	end
end