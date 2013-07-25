module GameTranslator
	class Game < ActiveRecord::Base
    translates :name, :short_description, :long_description, :wide_description, 
    	:instructions
    attr_accessible :name, :short_description, :long_description, :instructions
		# scopes
		scope :not_translated, conditions: { translated: false }
		scope :translated, conditions: { translated: true }
		scope :not_revised, conditions: { revised: false }
		scope :revised, conditions: { revised: true }
		scope :random, order: 'RAND()'
	end
end