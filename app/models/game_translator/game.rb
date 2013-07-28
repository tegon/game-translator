module GameTranslator
	class Game < ActiveRecord::Base
    # translated fields
    translates :name, :short_description, :long_description, :wide_description, 
    	:instructions
    globalize_accessors locales: GameTranslator::Language.languages_abbreviations

    # attr
    attr_accessible :name, :short_description, :long_description, :wide_description, 
    	:instructions, :user_id, :name_en, :short_description_en, :long_description_en, 
    	:wide_description_en, :instructions_en, :name_es, :short_description_es, 
    	:long_description_es, :wide_description_es, :instructions_es, :name_jp
    
    # relationship 
    belongs_to :user

		# scopes
		scope :not_translated, conditions: { translated: false }
		scope :translated, conditions: { translated: true }
		scope :not_revised, conditions: { revised: false }
		scope :revised, conditions: { revised: true }
		scope :random, order: 'RAND()', limit: '4'
		
		def reviser
			self.user if user.type == 'GameTranslator::Reviser' 
		end

		def translator
			self.user if user.type == 'GameTranslator::Translator'
		end

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