module GameTranslator
	class Language < ActiveRecord::Base
		# attr
		attr_accessible :abbreviation, :name

		# validations
		validates :name, presence: true, allow_blank: false
		validates :abbreviation, presence: true, allow_blank: false, 
			length: { minimum: 2, maximum: 4 }

		def self.languages_abbreviations
			GameTranslator::Language.all.map { |l| l.abbreviation }
		end
	end
end