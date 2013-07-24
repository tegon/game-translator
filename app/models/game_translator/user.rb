class GameTranslator::User < ActiveRecord::Base
  # devise
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  # relationship 
  has_many :games
  ROLES = %w[translator reviser]
end