module GameTranslator
	class Game < ActiveRecord::Base
		# # relations
		# has_one :reviser
		# has_one :translator

		# scopes
		scope :not_translated, conditions: { translated: false }
		scope :random, order: 'RAND()'
	end
end