class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :match_id
      t.datetime :finish_time
      t.string :result
      t.integer :remaining_moves
      t.timestamps
    end
  end
end
