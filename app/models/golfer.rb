class Golfer < ApplicationRecord
  belongs_to :society
  has_many :event_winners, dependent: :destroy
  has_many :season_tournament, through: :event_winners
  has_many :golfer_seasons, dependent: :destroy
  has_many :golfer_events, dependent: :destroy
  has_many :golfer_rounds, dependent: :destroy
  has_many :ryder_cup_appearances, dependent: :destroy
  has_many :ryder_cup_teams, through: :ryder_cup_appearances
  validates :name, presence: true
  
  def formatted_handicap
    if handicap < 0
     "+ #{handicap.abs.to_s}"
    else
      handicap.to_s
    end
  end
  
  def update_victory_count
    self.victories = event_winners.count
    self.save
  end
end
