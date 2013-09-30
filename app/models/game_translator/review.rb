module GameTranslator
  class Review < ActiveRecord::Base
    # attr
    attr_accessible :user, :status

    # relationship
    belongs_to :user
    has_many :translations

    # validates
    validates :status, presence: true, inclusion: { in: %w(pending accepted rejected) }

    # scopes
    scope :accepted, conditions: { status: 'accepted' }
    scope :rejected, conditions: { status: 'rejected' }
    scope :pending, conditions: { status: 'pending' }

    def self.to_review
      GameTranslator::User.translators.map do |user|
        if user.translations.not_revised.count >= 100
          review = GameTranslator::Review.create(status: 'pending')
          user.translations.not_revised.first(100).map { |t| t.update_attribute(:review, review) }
        end
      end
    end

    def pending?
      status == 'pending'
    end
  end
end