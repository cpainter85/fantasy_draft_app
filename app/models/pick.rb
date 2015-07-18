class Pick < ActiveRecord::Base
  belongs_to :team
  belongs_to :position

  validates :name, presence: true, length: { maximum: 50 }
  validates :from, length: { maximum: 75 }
  validates :team, presence: true
  validates :position, presence: true
end
