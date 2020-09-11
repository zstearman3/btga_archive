class GolferEvent < ApplicationRecord
  belongs_to :society
  belongs_to :golfer
  belongs_to :golfer_season
  belongs_to :season_tournament
  belongs_to :tournament
  belongs_to :course
  
  def calculate_score_to_par
    score - (season_tournament.rounds * course.par)
  end
end
