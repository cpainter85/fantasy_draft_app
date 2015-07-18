class Game < ActiveRecord::Base

  has_many :teams
  has_many :users, through: :teams
  has_many :positions
  has_many :picks, through: :teams

  validates :name, presence: true
  validates :description, length: {maximum: 1500}

  def create_positions(string)
    string.split("\n").each do |position|
      new_position = self.positions.new(name: position.strip)
      new_position.save
    end
  end

  def rounds
    self.positions.count
  end
end
