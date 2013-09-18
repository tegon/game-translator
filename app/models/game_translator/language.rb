module GameTranslator
  class Language < ActiveRecord::Base
    # attr
    attr_accessible :name, :code

    # validates
    validates :name, presence: true
    validates :code, presence: true, inclusion: { in: I18n.available_locales.map { |locale| locale.to_s } }

    def self.codes
      GameTranslator::Language.pluck(:code)
    end
  end
end