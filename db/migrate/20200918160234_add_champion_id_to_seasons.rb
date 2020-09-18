class AddChampionIdToSeasons < ActiveRecord::Migration[6.0]
  def change
    add_column :seasons, :champion_id, :integer
  end
end
