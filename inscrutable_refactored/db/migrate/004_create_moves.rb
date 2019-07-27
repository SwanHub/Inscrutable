class CreateMoves < ActiveRecord::Migration[5.2]
  def change
    create_table :moves do |t|
      t.integer :game_id
      t.string :move_type
      t.integer :shift
      t.integer :swap_1
      t.integer :swap_2
      t.integer :jump_first_piece
      t.integer :jump_number_of_pieces
      t.integer :jump_places
      t.timestamps
    end
  end
end
