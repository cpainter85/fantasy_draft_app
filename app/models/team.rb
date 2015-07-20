class Team < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  has_many :picks

  validates :name, presence: true, length: { maximum: 50 }
  validates :draft_order, presence: true
  validates :game, presence: { message: 'must exist' }
  validates :user, presence: { message: 'must exist' }

  def next_draft
    self.draft_order = self.game.teams.maximum(:draft_order) + 1
  end
end
