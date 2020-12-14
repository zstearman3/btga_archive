class RenameMatchupColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :match_play_matchups, :rounded_value, :round
  end
end
