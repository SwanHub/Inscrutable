class ChangeRemainingMovesDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column :games, :remaining_moves, :integer, default: 4
  end
end 
