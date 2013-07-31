module GameTranslator 
  class GameTranslation < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
  end
end