module GameTranslator 
  class GameTranslation < ActiveRecord::Base
    belongs_to :game
    belongs_to :user

    scope :not_revised, conditions: { revised: false }
    scope :revised, conditions: { revised: true }
  end
end