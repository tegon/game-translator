module GameTranslator 
  class Game::Translation < ActiveRecord::Base
    # relationship
    belongs_to :game
    belongs_to :user
    belongs_to :review
    
    # scopes
    scope :not_revised, conditions: { revised: false, review_id: nil }
    scope :revised, conditions: { revised: true }
  end
end