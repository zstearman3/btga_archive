class GolferEvent < ApplicationRecord
  attr_accessor :round_1_score, :round_2_score, :round_3_score, :round_4_score
  
  belongs_to :society
  belongs_to :golfer
  belongs_to :golfer_season
  belongs_to :season_tournament
  belongs_to :tournament
  belongs_to :course
  has_many :golfer_rounds, dependent: :destroy
  validates_uniqueness_of :golfer_id, scope: %i[season_tournament_id]
  
  def calculate_score_to_par
    score - (season_tournament.rounds * course.par)
  end
  
  def calculate_finish
    self.finish = GolferEvent.where(season_tournament: season_tournament).where("score < ?", score).count + 1
  end
  
  def calculate_points
    if finish && season_tournament
      self.points = season_tournament.points_hash[finish.to_s]
    else
      self.points = 0
    end
  end
  
  def display_score_to_par
    if score_to_par < 0
      score_to_par.to_s
    elsif score_to_par == 0
      'E'
    else
      "+#{score_to_par.to_s}"
    end
  end
end
