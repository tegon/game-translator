module GameTranslator
	class Language < ActiveRecord::Base
		# validations
		validates :name, presence: true, allow_blank: false
		validates :abbreviation, presence: true, allow_blank: false, 
			length: { minimum: 2, maximum: 5 }

		def self.abbreviations
			GameTranslator::Language.all.map { |l| l.abbreviation }
		end
	end
end