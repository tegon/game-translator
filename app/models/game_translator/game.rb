module GameTranslator
  class Game < ActiveRecord::Base
    # translated fields
    translates :name, :short_description, :long_description, :wide_description, 
      :instructions
    # globalize_accessors
    
    # relationship 
    has_many :game_translations

    # validates
    validates :status, presence: true, inclusion: { in: %w(not_translated translated translating) }

    # scopes
    scope :not_translated, conditions: { status: 'not_translated' }
    scope :translated, conditions: { status: 'translated' }
    scope :random, order: 'RAND()', limit: '4'

    translated_attribute_names.each do |attribute|
      GameTranslator::Language.all.map do |language|
        define_method "#{attribute}_#{language.code}" do
          Globalize.with_locale(language.code) do
            read_attribute attribute
          end
        end

        define_method "#{attribute}_#{language.code}=" do |value|
          Globalize.with_locale(language.code) do
            write_attribute(attribute, value)
          end
        end
      end
    end
  end
end