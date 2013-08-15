module GameTranslator
	class Language < ActiveRecord::Base
		# validates
		validates :name, presence: true, allow_blank: false
		validates :code, presence: true, allow_blank: false, 
			inclusion: { in: I18n.available_locales.map { |locale| locale.to_s } }

		def self.codes
			GameTranslator::Language.all.map { |l| l.code }
		end
	end
end