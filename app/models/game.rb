class Game < ActiveRecord::Base
  validates :name, presence: true
  validates :description, length: {maximum: 1500}
end
