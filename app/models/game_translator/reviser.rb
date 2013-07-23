module GameTransaltor
	class Reviser < User
		# relationship
		has_many :games
	end
end