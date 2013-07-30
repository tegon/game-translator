module GameTranslator
	class Game < ActiveRecord::Base
    # translated fields
    translates :name, :short_description, :long_description, :wide_description, 
    	:instructions
    globalize_accessors locales: GameTranslator::Language.languages_abbreviations
    
    # relationship 
    belongs_to :user
    has_many :game_translations

		# scopes
		scope :not_translated, conditions: { translated: false }
		scope :translated, conditions: { translated: true }
		scope :not_revised, conditions: { revised: false }
		scope :revised, conditions: { revised: true }
		scope :random, order: 'RAND()', limit: '4'

		def locales
			self.translations.map { |translation| translation.locale }
		end

		# extends globalize3 class :p
		#class GameTranslator::Game::Translation
		class Translation 
			# relationship
      belongs_to :game
      has_one :user, through: :game
    end
	end
end