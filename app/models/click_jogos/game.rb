module ClickJogos
	class Game < ActiveRecord::Base
		scope :not_translated, conditions: { translated: false }
	end
end