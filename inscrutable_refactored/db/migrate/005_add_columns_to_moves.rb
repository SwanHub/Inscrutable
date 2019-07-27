class AddColumnsToMoves < ActiveRecord::Migration[5.2]
  def change
    add_column :moves, :start_board_0, :integer
    add_column :moves, :start_board_1, :integer
    add_column :moves, :start_board_2, :integer
    add_column :moves, :start_board_3, :integer
    add_column :moves, :start_board_4, :integer
    add_column :moves, :start_board_5, :integer
    add_column :moves, :start_board_6, :integer
    add_column :moves, :start_board_7, :integer
    add_column :moves, :start_board_8, :integer
  end
end
