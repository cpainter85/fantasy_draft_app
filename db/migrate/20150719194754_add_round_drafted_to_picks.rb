class AddRoundDraftedToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :round_drafted, :integer
  end
end
