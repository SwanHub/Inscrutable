class RemoveStartTimeColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :start_time
    remove_column :matches, :start_time
  end
end
