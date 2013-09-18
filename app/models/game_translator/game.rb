module GameTranslator
  class Game < ActiveRecord::Base
    # attr
    attr_accessible :name, :short_description, :long_description, :wide_description, :instructions, :status

    # translated fields
    translates :name, :short_description, :long_description, :wide_description, :instructions
    globalize_accessors

    # validates
    validates :status, presence: true, inclusion: { in: %w(not_translated translated translating) }

    # scopes
    scope :not_translated, conditions: { status: 'not_translated' }
    scope :translated, conditions: { status: 'translated' }
    scope :random, order: 'RAND()', limit: '4'

    # extending globalize3 class
    class Translation < Globalize::ActiveRecord::Translation
      # attr_accessible :game
      # relationship
      belongs_to :game
      belongs_to :user
      belongs_to :review

      # scopes
      scope :not_revised, conditions: { revised: false, review_id: nil }
      scope :revised, conditions: { revised: true }
    end
  end
end