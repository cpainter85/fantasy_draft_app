class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :game_id
      t.string :name
      t.timestamps
    end
  end
end
