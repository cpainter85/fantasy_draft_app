class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :team_id
      t.integer :position_id
      t.string :name
      t.string :from
      t.timestamps
    end
  end
end
