class User < ActiveRecord::Base
  has_secure_password

  has_many :teams
  has_many :games, through: :teams

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }
end
