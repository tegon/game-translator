class GameTranslator::User < ActiveRecord::Base
  # devise
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role
  
  # relationship 
  has_many :games

  ROLES = %w[translator reviser]

  def reviser?
  	self.role == 'reviser'
  end

  def translator?
  	self.role == 'translator'
  end
end