class EventWinner < ApplicationRecord
  belongs_to :golfer
  belongs_to :season_tournament
  belongs_to :golfer_season
  
  def winner_name
    golfer.name
  end
  
  def update_event_level
    self.event_level = season_tournament.event_level
    self.save
  end
  
end
