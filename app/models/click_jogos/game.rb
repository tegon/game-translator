module ClickJogos
	class Game < ActiveRecord::Base
		scope :not_translated, conditions: { translated: false }
		scope :random, order: 'RAND()'
	end
end