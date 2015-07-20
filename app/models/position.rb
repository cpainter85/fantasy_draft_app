class Position < ActiveRecord::Base
  belongs_to :game
  has_many :picks

  validates :name, presence: true, length: {maximum: 50}
  validates :game, presence: true
end
