class AddRankToGolferSeasons < ActiveRecord::Migration[6.0]
  def change
    add_column :golfer_seasons, :rank, :integer
  end
end
