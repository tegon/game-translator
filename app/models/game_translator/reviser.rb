module GameTransaltor
	class Reviser < ActiveRecord::Base
		# relations
		has_many :games
	end
end