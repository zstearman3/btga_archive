class AddMatchPlayToSeasonTouraments < ActiveRecord::Migration[6.0]
  def change
    add_column :season_tournaments, :match_play, :boolean, default: false
  end
end
