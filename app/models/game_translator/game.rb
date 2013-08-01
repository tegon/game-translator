module GameTranslator
	class Game < ActiveRecord::Base
    # translated fields
    translates :name, :short_description, :long_description, :wide_description, 
    	:instructions
    globalize_accessors locales: GameTranslator::Language.languages_abbreviations
    
    # relationship 
    has_many :game_translations

		# scopes
		scope :not_translated, conditions: { translated: false }
		scope :translated, conditions: { translated: true }
		scope :random, order: 'RAND()', limit: '4'

		def locales
			self.translations.map { |translation| translation.locale }
		end
	end
end