class AddGolferSeasonToGolferRound < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :golfer_rounds, :golfer_season
  end
end
