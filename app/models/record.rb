class Record < ApplicationRecord
  belongs_to :society
  belongs_to :golfer, optional: true
  belongs_to :golfer_event, optional: true
  belongs_to :season_tournament, optional: true
  
  class << self
    def generate_all_records
      get_low_round
    end
    
    def get_low_round
      r = Record.find(1)
      round = GolferRound.order(score: :asc, created_at: :asc).first
      r.value = round.score
      r.date = round.created_at
      r.golfer_event = round.golfer_event
      r.golfer = round.golfer
      r.season_tournament = round.season_tournament
      r.save
    end
  end
  
  def golfer_name
    golfer ? golfer.name : "N/A"
  end
  
  def event_name
    season_tournament ? season_tournament.tournament_name_with_year : "N/A"
  end
end
