module GameTranslator
  class User < ActiveRecord::Base
    # devise
    devise :database_authenticatable, :registerable,
           :rememberable, :trackable, :validatable

    # relationship
    has_many :games
    has_many :game_translations, through: :game_id
    has_many :reviews

    # validates
    validates :name, presence: true, allow_blank: false, length: { minimum: 3 }
    validates :role, presence: true, inclusion: { in: %w(translator reviser) }

    # scopes
    scope :translators, conditions: { role: 'translator' }
    scope :revisers, conditions: { role: 'reviser' }

    # cancan roles
    ROLES = %w[translator reviser]

    def reviser?
      self.role == 'reviser'
    end

    def translator?
      self.role == 'translator'
    end
  end
end