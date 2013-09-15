# encoding: UTF-8

module GameTranslator
  class Game < ActiveRecord::Base
    # translated fields
    translates :name, :short_description, :long_description, :wide_description, :instructions

    # validates
    validates :status, presence: true, inclusion: { in: %w(not_translated translated translating) }

    # scopes
    scope :not_translated, conditions: { status: 'not_translated' }
    scope :translated, conditions: { status: 'translated' }
    scope :random, order: 'RAND()', limit: '4'

    # defining accessors for translated fields ex:(name_en)
    translated_attribute_names.each do |attribute|
      I18n.available_locales.map do |language|
        define_method "#{ attribute }_#{ language.to_s.underscore }" do
          I18n.with_locale(language) do
            read_attribute attribute
          end
        end

        define_method "#{ attribute }_#{ language.to_s.underscore }=" do |value|
          return false if value.nil? || value.blank?
          I18n.with_locale(language) do
            write_attribute(attribute, value)
          end
        end
      end
    end

    # extending globalize3 class
    class Translation < Globalize::ActiveRecord::Translation
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