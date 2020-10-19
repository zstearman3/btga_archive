class GolferRound < ApplicationRecord
  belongs_to :society
  belongs_to :course
  belongs_to :golfer
  belongs_to :golfer_event
  belongs_to :golfer_season
  belongs_to :season_tournament
  belongs_to :tournament
  
  def init_from_event i, score
    self.society = golfer_event.society
    self.course = golfer_event.course
    self.golfer = golfer_event.golfer
    self.golfer_season = golfer_event.golfer_season
    self.season_tournament = golfer_event.season_tournament
    self.tournament = golfer_event.tournament
    self.score = score
    self.round_order = i
    self.score_to_par = score - course.par
  end
  
  def score_to_par
    to_par = score - course.par
    to_par = "+ #{to_par}" if to_par > 0
    to_par = 'E' if to_par == 0
  end
end
