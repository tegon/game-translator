module GameTranslator
  class Review < ActiveRecord::Base
    # relationship
    belongs_to :user
    has_many :games

    # validates
    validates :status, presence: true, inclusion: { in: %w(pending accepted rejected) }

    def self.to_review
      GameTranslator::User.translators.map do |user|
        if user.games.not_revised.count >= 100
          review = GameTranslator::Review.create(user: user, status: 'pending')
          user.games.not_revised.first(100).map { |t| t.update_attribute(:review, review) }
        end
      end
    end
  end
end