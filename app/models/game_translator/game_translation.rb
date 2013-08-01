module GameTranslator 
  class GameTranslation < ActiveRecord::Base
    # relationship
    belongs_to :game
    belongs_to :user

    # scopes
    scope :not_revised, conditions: { revised: false }
    scope :revised, conditions: { revised: true }
    scope :rejected, conditions: { rejected: true }
  end
end