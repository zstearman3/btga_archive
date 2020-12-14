class AddCurrentRoundToSeasonTouraments < ActiveRecord::Migration[6.0]
  def change
    add_column :season_tournaments, :current_round, :integer, default: 0
  end
end
