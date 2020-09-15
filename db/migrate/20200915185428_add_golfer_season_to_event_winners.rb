class AddGolferSeasonToEventWinners < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :event_winners, :golfer_season
  end
end
