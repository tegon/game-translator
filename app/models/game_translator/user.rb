module GameTranslator
  class User < ActiveRecord::Base
    # devise
    devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

    # relationship
    has_many :translations, class_name: Game::Translation
    has_many :reviews

    # validates
    validates :name, presence: true, length: { minimum: 3 }
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