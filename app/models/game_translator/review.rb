module GameTranslator
  class Review < ActiveRecord::Base
    # relationship
    belongs_to :user
    has_many :game_translations
  end
end