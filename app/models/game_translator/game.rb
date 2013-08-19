module GameTranslator
  class Game < ActiveRecord::Base
    # translated fields
    translates :name, :short_description, :long_description, :wide_description, 
      :instructions
    globalize_accessors
    
    # relationship 
    has_many :game_translations

    # validates
    validates :status, presence: true, inclusion: { in: %w(not_translated translated translating) }

    
    GameTranslator::Language.codes.each do |locale|
      validates "name_#{ locale }".to_sym, presence: true, allow_blank: false 
      validates "short_description_#{ locale }".to_sym, presence: true, allow_blank: false 
      validates "long_description_#{ locale }".to_sym, presence: true, allow_blank: false 
      validates "instructions_#{ locale }".to_sym, presence: true, allow_blank: false
    end

    # scopes
    scope :not_translated, conditions: { status: 'not_translated' }
    scope :translated, conditions: { status: 'translated' }
    scope :random, order: 'RAND()', limit: '4'
  end
end