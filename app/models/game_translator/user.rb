class GameTranslator::User < ActiveRecord::Base
  # devise
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  
  # attr
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role
  
  # relationship 
  has_many :games

  # validates
  validates :name, presence: true, allow_blank: false, length: { minimum: 3 }
  validates :role, presence: true, inclusion: { in: %w(translator reviser) }

  # cancan roles
  ROLES = %w[translator reviser]

  def reviser?
  	self.role == 'reviser'
  end

  def translator?
  	self.role == 'translator'
  end
end