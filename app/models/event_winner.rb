class EventWinner < ApplicationRecord
  belongs_to :golfer
  belongs_to :season_tournament
  belongs_to :golfer_season
  
  def winner_name
    golfer.name
  end
end
