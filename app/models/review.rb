module GameTranslator
	class Review < ActiveRecord::Base
		belongs_to :reviser
	end
end