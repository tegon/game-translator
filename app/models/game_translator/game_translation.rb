module GameTranslator 
  class GameTranslation < ActiveRecord::Base
    # relationship
    belongs_to :game
    belongs_to :user

    # scopes
    scope :not_revised, conditions: { revised: false }
    scope :revised, conditions: { revised: true }
    scope :rejected, conditions: { rejected: true }

    def self.to_review
      GameTranslator::User.translators.map do |user|
        if user.game_translations.not_revised.count >= 100
          {
            user: user,
            sample: user.game_translations.not_revised.sample
          } 
        end
      end
    end
  end
end