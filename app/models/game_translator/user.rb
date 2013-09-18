module GameTranslator
  class User < ActiveRecord::Base
    # attr
    attr_accessible :name, :email, :password, :password_confirmation, :role, :remember_me

    # devise
    devise :database_authenticatable, :rememberable, :trackable, :validatable

    # relationship
    has_many :translations, class_name: GameTranslator::Game::Translation
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
      role == 'reviser'
    end

    def translator?
      role == 'translator'
    end
  end
end