class Pick < ActiveRecord::Base
  belongs_to :team
  belongs_to :position

  validates :name, presence: true, length: { maximum: 50 }
  validates :from, length: { maximum: 75 }
  validates :team, presence: { message: 'must exist' }
  validates :position, presence: { message: 'must exist' }, uniqueness: {scope: :team_id, message: 'has already been filled on your team'}
  validates :round_drafted, presence: true, uniqueness: {scope: :team_id, message: 'has already been filled on your team'}
end
