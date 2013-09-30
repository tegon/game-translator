module GameTranslator
  class Translation < Globalize::ActiveRecord::Translation
    self.table_name = 'game_translations'
    # relationship
    belongs_to :game
    belongs_to :user
    belongs_to :review

    # scopes
    scope :not_revised, conditions: { revised: false, review_id: nil }
    scope :revised, conditions: { revised: true }

    def self.of_date(start_date, end_date)
      where(created_at: start_date..end_date)
    end
  end
end