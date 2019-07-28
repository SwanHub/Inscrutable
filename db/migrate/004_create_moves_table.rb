class CreateMovesTable < ActiveRecord::Migration[5.2]
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
      t.integer :start_board_0
      t.integer :start_board_1
      t.integer :start_board_2
      t.integer :start_board_3
      t.integer :start_board_4
      t.integer :start_board_5
      t.integer :start_board_6
      t.integer :start_board_7
      t.integer :start_board_8
      t.timestamps
    end
  end
end
