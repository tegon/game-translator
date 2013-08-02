class GameTranslator::User < ActiveRecord::Base
  # devise
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  
  # relationship  
  has_many :game_translations

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

  def translations_ids(revised=false)
    if revised
      self.game_translations.revised.map { |translation| translation.id }
    else
      self.game_translations.not_revised.map { |translation| translation.id }
    end
  end
end