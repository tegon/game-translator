module GameTranslator
	class Translation < ActiveRecord::Base
		belongs_to :translator
	end
end