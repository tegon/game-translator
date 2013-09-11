module GameTranslator
  class Review < ActiveRecord::Base
    # relationship
    belongs_to :user
    has_many :translations, class_name: GameTranslator::Game::Translation

    # validates
    validates :status, presence: true, inclusion: { in: %w(pending accepted rejected) }

    def self.to_review
      GameTranslator::User.translators.map do |user|
        p '/'*100
        p user.not_revised_count
        if user.not_revised_count >= 100
          p '/'*200
          review = GameTranslator::Review.create(user: user, status: 'pending')
          user.translations.not_revised.first(100).map { |t| t.update_attribute(:review, review) }
        end
      end
    end
  end
end