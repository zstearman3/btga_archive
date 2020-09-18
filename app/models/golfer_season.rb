class GolferSeason < ApplicationRecord
  belongs_to :society
  belongs_to :season
  belongs_to :golfer
  has_many :golfer_events, dependent: :destroy
  has_many :golfer_rounds, dependent: :destroy
  has_many :event_winners, dependent: :destroy
  
  def name
    golfer.name
  end
  
  def update_points
    self.points = golfer_events.sum(:points)
  end
  
  def update_events
    self.events = golfer_events.count
  end
  
  def update_wins
    self.wins = event_winners.count
  end
  
  def update_season
    golfer.update_victory_count
    self.update_points
    self.update_events
    self.update_wins
    self.save
  end
end
