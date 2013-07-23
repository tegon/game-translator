module GameTranslator
	class Game < ActiveRecord::Base
		# scopes
		scope :not_translated, conditions: { translated: false }
		scope :random, order: 'RAND()'
	end
end