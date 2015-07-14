class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :game_id
      t.integer :user_id
      t.string :name
      t.integer :draft_order
      t.timestamps
    end
  end
end
