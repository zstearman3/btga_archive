class EventWinner < ApplicationRecord
  belongs_to :golfer
  belongs_to :season_tournament
  
  def winner_name
    golfer.name
  end
end
