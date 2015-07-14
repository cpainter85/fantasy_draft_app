class Team < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :draft_order, presence: true
end
