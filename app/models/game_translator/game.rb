module GameTranslator
  class Game < ActiveRecord::Base
    # attr
    attr_accessible :name, :short_description, :long_description, :wide_description, :instructions, :status

    # relationship
    has_many :translations

    # translated fields
    translates :name, :short_description, :long_description, :wide_description, :instructions
    globalize_accessors

    # validates
    validates :status, presence: true, inclusion: { in: %w(not_translated translated translating) }

    # scopes
    scope :not_translated, conditions: { status: 'not_translated' }
    scope :translated, conditions: { status: 'translated' }
    scope :random, order: 'RAND()', limit: '4'
  end
end