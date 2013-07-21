module GameTransaltor
	class Reviser < ActiveRecord::Base
		has_many :reviews
	end
end