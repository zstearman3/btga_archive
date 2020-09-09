class RenameTournamentType < ActiveRecord::Migration[6.0]
  def change
    rename_table :tournament_types, :tournament_levels
  end
end
