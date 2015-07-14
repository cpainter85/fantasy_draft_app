class Game < ActiveRecord::Base

  has_many :teams
  has_many :users, through: :teams
  
  validates :name, presence: true
  validates :description, length: {maximum: 1500}
end
