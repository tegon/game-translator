module GameTranslator
	class Game < ActiveRecord::Base
		# scopes
		scope :not_translated, conditions: { translated: false }
		scope :translated, conditions: { translated: true }
		scope :not_revised, conditions: { revised: false }
		scope :revised, conditions: { revised: true }
		scope :random, order: 'RAND()'
	end
end