module GameTranslator
	class Game < ActiveRecord::Base
    # translated fields
    translates :name, :short_description, :long_description, :wide_description, 
    	:instructions
    
    # attr
    attr_accessible :name, :short_description, :long_description, :wide_description, 
    	:instructions, :user_id
    
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
	end
end