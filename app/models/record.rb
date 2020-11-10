class Record < ApplicationRecord
  belongs_to :society
  belongs_to :golfer, optional: true
  belongs_to :golfer_event, optional: true
  belongs_to :season_tournament, optional: true
  
  class << self
    
    def generate_all_records
      self.generate_low_round
      self.generate_low_round_to_par
      self.generate_low_two_round_event
    end
    
    def set_all_records(low_event_event, low_event_score, low_round_event, low_round_score)
      self.set_low_event(low_event_event, low_event_score)
      self.set_low_event_to_par(low_event_event, low_event_score)
      self.set_low_round(low_round_event, low_round_score)
      self.set_low_round_to_par(low_round_event, low_round_score)
    end
    
    def generate_low_round
      r = Record.find_or_create_by(name: 'Best Round (Strokes)')
      round = GolferRound.order(score: :asc, created_at: :asc).first
      r.value = round.score
      r.date = round.created_at
      r.golfer_event = round.golfer_event
      r.golfer = round.golfer
      r.season_tournament = round.season_tournament
      r.decimal_places = 0
      r.society = Society.first
      r.save
    end
    
    def generate_low_round_to_par
      r = Record.find_or_create_by(name: 'Best Round (To Par)')
      round = GolferRound.order(score_to_par: :asc, created_at: :asc).first
      r.value = round.score_to_par
      r.date = round.created_at
      r.golfer_event = round.golfer_event
      r.golfer = round.golfer
      r.season_tournament = round.season_tournament
      r.decimal_places = 0
      r.society = Society.first
      r.save
    end
    
    def generate_low_two_round_event
      r = Record.find_or_create_by(name: 'Best Two-Round Tourney (Strokes)')
      event = GolferEvent.includes(:season_tournament).where(season_tournaments: {rounds: 2})
        .order(score: :asc, created_at: :asc).first
      r.value = event.score
      r.date = event.created_at
      r.golfer_event = event
      r.golfer = event.golfer
      r.season_tournament = event.season_tournament
      r.decimal_places = 0
      r.society = Society.first
      r.save
    end
    
    def generate_low_two_round_event_to_par
      r = Record.find_or_create_by(name: 'Best Two-Round Tourney (To Par)')
      event = GolferEvent.includes(:season_tournament).where(season_tournaments: {rounds: 2})
        .order(score_to_par: :asc, created_at: :asc).first
      r.value = event.score_to_par
      r.date = event.created_at
      r.golfer_event = event
      r.golfer = event.golfer
      r.season_tournament = event.season_tournament
      r.decimal_places = 0
      r.society = Society.first
      r.save
    end
    
    def generate_low_two_round_event_to_par
      r = Record.find_or_create_by(name: 'Best Two-Round Tourney (To Par)')
    end
    
    def set_low_round(event, score)
      r = Record.find_or_create_by(name: 'Best Round (Strokes)')
      if score < r.value
        r.value = score
        r.date = event.created_at
        r.golfer_event = event
        r.golfer = event.golfer
        r.season_tournament = event.season_tournament
        r.save
      end
    end
    
    def set_low_round_to_par(event, score)
      r = Record.find_or_create_by(name: 'Best Round (To Par)')
      if score < r.value
        r.value = score
        r.date = event.created_at
        r.golfer_event = event
        r.golfer = event.golfer
        r.season_tournament = event.season_tournament
        r.save
      end
    end
    
  end
  
  def golfer_name
    golfer ? golfer.name : "N/A"
  end
  
  def event_name
    season_tournament ? season_tournament.tournament_name_with_year : "N/A"
  end
  
  def rounded_value
    if decimal_places == 0
      value.round()
    else
      decimal_places ||= 2
      value.round(decimal_places)
    end
  end
  
end
