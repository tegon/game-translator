module GameTranslator 
  class GameTranslation < ActiveRecord::Base
    # relationship
    belongs_to :game
    belongs_to :user
    belongs_to :review

    # scopes
    scope :not_revised, conditions: { revised: false, review_id: nil }
    scope :revised, conditions: { revised: true }
    scope :rejected, conditions: { rejected: true }
  end
end