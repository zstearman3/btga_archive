class ChangeTournamentTypeToLevelName < ActiveRecord::Migration[6.0]
  def change
    rename_column :tournament_levels, :type, :name
    rename_column :tournaments, :tournament_type_id, :tournament_level_id
  end
end
