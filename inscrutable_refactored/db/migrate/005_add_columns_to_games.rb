class AddColumnsToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :board_0, :integer, default: 1
    add_column :games, :board_1, :integer, default: 2
    add_column :games, :board_2, :integer, default: 3
    add_column :games, :board_3, :integer, default: 4
    add_column :games, :board_4, :integer, default: 5
    add_column :games, :board_5, :integer, default: 6
    add_column :games, :board_6, :integer, default: 7
    add_column :games, :board_7, :integer, default: 8
    add_column :games, :board_8, :integer, default: 9
  end
end
