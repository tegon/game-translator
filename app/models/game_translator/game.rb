module GameTranslator
	class Game < ActiveRecord::Base
    # translated fields
    translates :name, :short_description, :long_description, :wide_description, 
    	:instructions
    globalize_accessors locales: GameTranslator::Language.abbreviations
    
    # relationship 
    has_many :game_translations

		# scopes
		scope :not_translated, conditions: { status: 'not_translated' }
		scope :translated, conditions: { status: 'translated' }
		scope :random, order: 'RAND()', limit: '4'

		def locales
			self.translations.map { |translation| translation.locale }
		end
	end
end