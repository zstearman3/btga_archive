class AddFinalizedToSeasonTournament < ActiveRecord::Migration[6.0]
  def change
    add_column :season_tournaments, :finalized, :boolean, default: false
  end
end
