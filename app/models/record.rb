class Record < ApplicationRecord
  belongs_to :society
  belongs_to :golfer, optional: true
  belongs_to :golfer_event, optional: true
  belongs_to :season_tournament, optional: true
  
  class << self
    
    def generate_all_records
      self.delete_all
      self.generate_low_round
      self.generate_low_round_to_par
      self.generate_low_two_round_event
      self.generate_low_two_round_event_to_par
      self.generate_low_four_round_event
      self.generate_low_four_round_event_to_par
      self.generate_low_scoring_average
    end
    
    def set_all_records(event)
      low_event = event.golfer_events.order(score: :asc).first
      low_round = event.golfer_rounds.order(score: :asc).first
      self.set_low_event(low_event)
      self.set_low_event_to_par(low_event)
      self.set_low_round(low_round)
      self.set_low_round_to_par(low_round)
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
      r.to_par = false
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
      r.to_par = true
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
      r.to_par = false
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
      r.to_par = true
      r.save
    end
    
    def generate_low_four_round_event
      r = Record.find_or_create_by(name: 'Best Four-Round Tourney (Strokes)')
      event = GolferEvent.includes(:season_tournament).where(season_tournaments: {rounds: 4})
        .order(score: :asc, created_at: :asc).first
      r.value = event.score
      r.date = event.created_at
      r.golfer_event = event
      r.golfer = event.golfer
      r.season_tournament = event.season_tournament
      r.decimal_places = 0
      r.society = Society.first
      r.to_par = false
      r.save
    end
    
    def generate_low_four_round_event_to_par
      r = Record.find_or_create_by(name: 'Best Four-Round Tourney (To Par)')
      event = GolferEvent.includes(:season_tournament).where(season_tournaments: {rounds: 4})
        .order(score_to_par: :asc, created_at: :asc).first
      r.value = event.score_to_par
      r.date = event.created_at
      r.golfer_event = event
      r.golfer = event.golfer
      r.season_tournament = event.season_tournament
      r.decimal_places = 0
      r.society = Society.first
      r.to_par = true
      r.save
    end
    
    def generate_low_scoring_average
      r = Record.find_or_create_by(name: 'Lowest Scoring Average (Season)')
      season = GolferSeason.includes(:golfer_rounds).sort_by {|season| season.golfer_rounds.average(:score)}.first
      r.value = season.golfer_rounds.average(:score)
      r.date = season.updated_at
      r.golfer = season.golfer
      r.decimal_places = 2
      r.society = Society.first
      r.save
    end
    
    def set_low_round(round)
      r = Record.find_or_create_by(name: 'Best Round (Strokes)')
      if round.score < r.value
        r.value = score
        r.date = event.created_at
        r.golfer_event = event
        r.golfer = event.golfer
        r.season_tournament = event.season_tournament
        r.save
      end
    end
    
    def set_low_round_to_par(round)
      r = Record.find_or_create_by(name: 'Best Round (To Par)')
      if round.score_to_par < r.value
        r.value = score
        r.date = event.created_at
        r.golfer_event = event
        r.golfer = event.golfer
        r.season_tournament = event.season_tournament
        r.save
      end
    end
    
    def set_low_event(event)
      r = nil
      if event.season_tournament.rounds == 2
        r = Record.find_or_create_by(name: 'Best Two-Round Tourney (Strokes)')
      elsif event.season_tournament.round == 4
        r = Record.find_or_create_by(name: 'Best Four-Round Tourney (Strokes)')
      end
      return if r == nil
      if event.score < r.value
        r.value = event.score
        r.date = event.created_at
        r.golfer_event = event
        r.golfer = event.golfer
        r.season_tournament = event.season_tournament
        r.save
      end
    end
      
    def set_low_event_to_par(event)
      r = nil
      if event.season_tournament.rounds == 2
        r = Record.find_or_create_by(name: 'Best Two-Round Tourney (To Par)')
      elsif event.season_tournament.round == 4
        r = Record.find_or_create_by(name: 'Best Four-Round Tourney (To Par)')
      end
      return if r == nil
      if event.score_to_par < r.value
        r.value = event.score_to_par
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
  
  def display_to_par
    value = self.rounded_value
    if value < 0
      value.to_s
    elsif value > 0
      "+" + value.to_s
    else
      "E"
    end
  end
  
  def display_value
    if self.to_par
      display_to_par
    else
      rounded_value
    end
  end
  
end
