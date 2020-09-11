class GolferEvent < ApplicationRecord
  attr_accessor :round_1_score, :round_2_score, :round_3_score, :round_4_score
  
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
