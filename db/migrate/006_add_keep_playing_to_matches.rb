class AddKeepPlayingToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :keep_playing, :boolean, default: true
  end
end
