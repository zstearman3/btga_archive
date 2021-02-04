class SeasonTournament < ApplicationRecord
  include PointsCalculator
  belongs_to :society
  belongs_to :tournament
  belongs_to :season
  belongs_to :course
  has_many :event_winners
  has_many :headlines
  has_many :golfers, through: :event_winners
  has_many :golfer_events, dependent: :destroy
  has_many :golfer_rounds, dependent: :destroy
  has_many :match_play_matchups, dependent: :destroy
  validates :season_order, numericality: { only_integer: true }
  validates_uniqueness_of :season_id, scope: %i[tournament_id]
  validates_uniqueness_of :start_date, scope: %i[season_id]
  
  def tournament_name
    tournament.current_name(year)
  end
  
  def course_name
    course.name
  end
  
  def year
    season.year
  end
  
  def type_stub
    if event_level
      event_level[0].upcase
    end
  end
  
  def tournament_name_with_year
    "#{tournament_name} (#{year})"
  end
  
  def update_event_level
    self.event_level = tournament.tournament_level.name.downcase
    save
  end
  
  def display_winners
    if event_winners.count < 1
      "N/A"
    elsif event_winners.count > 1
      winners_string = event_winners.first.golfer.name
      event_winners.drop(1).each do |winner|
        winners_string += ", #{winner.golfer.name}"
      end
      winners_string
    else
      event_winners.first.golfer.name
    end
  end
  
  def winning_score
    score = golfer_events.order(score: :asc).first.score if golfer_events.count > 0
    score ||= "N/A"
  end
  
  def winning_score_to_par
    ScoreToPar.convert_score_to_par(winning_score, course.par * rounds) if winning_score != "N/A"
  end
  
  def points_hash
    case tournament.tournament_level_id
    when 1
      {"1" => 500,
       "2" => 300,
       "3" => 190,
       "4" => 135,
       "5" => 110,
       "6" => 100,
       "7" => 90,
       "8" => 85,
       "9" => 80,
       "10" => 75
      }
    when 2
      {"1" => 550,
       "2" => 315,
       "3" => 200,
       "4" => 140,
       "5" => 115,
       "6" => 105,
       "7" => 95,
       "8" => 89,
       "9" => 83,
       "10" => 78
      }
    when 3
      {"1" => 600,
       "2" => 330,
       "3" => 210,
       "4" => 150,
       "5" => 120,
       "6" => 110,
       "7" => 100,
       "8" => 94,
       "9" => 88,
       "10" => 82
      }
    when 4
      {"1" => 2000,
       "2" => 1200,
       "3" => 760,
       "4" => 540,
       "5" => 440,
       "6" => 400,
       "7" => 360,
       "8" => 340,
       "9" => 320,
       "10" => 300
      }
    else
      {"1" => 1000,
       "2" => 6000,
       "3" => 380,
       "4" => 270,
       "5" => 220,
       "6" => 200,
       "7" => 180,
       "8" => 170,
       "9" => 160,
       "10" => 150
      }
    end
  end
  
  def finalize_event
    winner_name = nil
    winner_score = nil
    golfer_events.each do |event|
      if !event.completed
        return false
      end
      event.calculate_finish
      event.calculate_points
      event.save
      if event.finish == 1
        event_winner = EventWinner.new(golfer: event.golfer, season_tournament: self, golfer_season: event.golfer_season,
                                       event_level: self.event_level)
        event_winner.save
        event.golfer.update_victory_count
        winner_name = event.golfer.name
        winner_score = event.display_score_to_par
      end
    end
    headline = headlines.new()
    headline.generate_event_winner_story(winner_name, tournament_name, winner_score)
    season.golfer_seasons.each { |g| g.update_season }
    # calculate_season_points season.year
    self.finalized = true
    self.save ? true : false
    Record.generate_all_records
  end
  
  def generate_matchups
    if !match_play || season.golfer_seasons.count < 8
      return false
    end
    case current_round
    when 0 || nil
      if match_round_of_eight
        self.current_round += 1
        self.save
      else return false
      end
    when 1
      if match_semi_finals
        self.current_round += 1
        self.save
      else return false
      end
    when 2
      if match_finals
        self.current_round += 1
        self.save
      else return false
      end
    end
    true
  end
  
  def finalize_match_play
    winner_name = nil
    winner_score = nil
    championship = match_play_matchups.find_by(winner_place: 1)
    third_place = match_play_matchups.find_by(winner_place: 3)
    fifth_place = match_play_matchups.find_by(winner_place: 5)
    seventh_place = match_play_matchups.find_by(winner_place: 7)
    first_golfer_event = GolferEvent.new(golfer: championship.winner_golfer, finish: 1)
    second_golfer_event = GolferEvent.new(golfer: championship.loser_golfer, finish: 2)
    third_golfer_event = GolferEvent.new(golfer: third_place.winner_golfer, finish: 3)
    fourth_golfer_event = GolferEvent.new(golfer: third_place.loser_golfer, finish: 4)
    fifth_golfer_event = GolferEvent.new(golfer: fifth_place.winner_golfer, finish: 5)
    sixth_golfer_event = GolferEvent.new(golfer: fifth_place.loser_golfer, finish: 6)
    seventh_golfer_event = GolferEvent.new(golfer: seventh_place.winner_golfer, finish: 7)
    eighth_golfer_event = GolferEvent.new(golfer: seventh_place.loser_golfer, finish: 8)
    golfer_events = [
      first_golfer_event,
      second_golfer_event,
      third_golfer_event,
      fourth_golfer_event,
      fifth_golfer_event,
      sixth_golfer_event,
      seventh_golfer_event,
      eighth_golfer_event
    ]
    golfer_events.each do |event|
      event.season_tournament = self
      event.society = Society.last
      event.golfer_season = GolferSeason.find_or_create_by(golfer: event.golfer, season: self.season)
      event.tournament = self.tournament
      event.course = self.course
      event.completed = true
      event.calculate_points
      print event.inspect
      event.save
      if event.finish == 1
        event_winner = EventWinner.new(golfer: event.golfer, season_tournament: self, golfer_season: event.golfer_season,
                                       event_level: self.event_level)
        event_winner.save
        event.golfer.update_victory_count
        winner_name = event.golfer.name
        winner_score = event.display_score_to_par
      end
    end
    headline = headlines.new()
    headline.generate_event_winner_story(winner_name, tournament_name, winner_score)
    season.golfer_seasons.each { |g| g.update_season }
    self.finalized = true
    self.save ? true : false
    Record.generate_all_records
  end
  
  def unfinalize_event
    event_winners.destroy_all
    headlines.destroy_all
    # golfer_events.update_all(points: 0)
    season.golfer_seasons.each { |g| g.update_season }
    # calculate_season_points season.year
    self.finalized = false
    self.save ? true : false
  end
  
  def select_default_course
    @course = Tournament.find(params[:id]).course
  end
  
  def formatted_end_date
    end_date.strftime("%m/%d/%Y")
  end
  
  private
  
  def match_round_of_eight
    golfers = season.golfer_seasons.order(rank: :asc).first(8)
    4.times do |n|
      matchup = MatchPlayMatchup.new()
      matchup.favorite_golfer = golfers[n].golfer
      matchup.underdog_golfer = golfers[7 - n].golfer
      matchup.season_tournament_id = self.id
      matchup.favorite_seed = n + 1
      matchup.underdog_seed = 8 - n
      matchup.round = current_round + 1
      return false unless matchup.save
    end
    true
  end
  
  def match_semi_finals
    previous_matchups = self.match_play_matchups.where(round: 1).order(favorite_seed: :asc)
    return false if previous_matchups.where(winner_golfer: nil).count > 0 
    2.times do |n|
      winner_matchup = MatchPlayMatchup.new()
      winner_matchup.favorite_golfer = previous_matchups[n].winner_golfer
      winner_matchup.underdog_golfer = previous_matchups[3 - n].winner_golfer
      winner_matchup.season_tournament_id = self.id
      winner_matchup.favorite_seed = previous_matchups[n].winner_seed
      winner_matchup.underdog_seed = previous_matchups[3 - n].winner_seed
      winner_matchup.round = current_round + 1
      return false unless winner_matchup.save
      loser_matchup = MatchPlayMatchup.new()
      loser_matchup.favorite_golfer = previous_matchups[3 - n].loser_golfer
      loser_matchup.underdog_golfer = previous_matchups[n].loser_golfer
      loser_matchup.season_tournament_id = self.id
      loser_matchup.favorite_seed = previous_matchups[3 - n].loser_seed
      loser_matchup.underdog_seed = previous_matchups[n].loser_seed
      loser_matchup.round = current_round + 1
      loser_matchup.losers_bracket = true
      return false unless loser_matchup.save
    end
    true
  end
  
  def match_finals
    previous_winners_bracket = self.match_play_matchups.where(round: 2, losers_bracket: false).order(favorite_seed: :asc)
    previous_losers_bracket = self.match_play_matchups.where(round: 2, losers_bracket: true).order(favorite_seed: :asc)
    # Make Championship Game
    championship = MatchPlayMatchup.new(season_tournament_id: self.id, round: current_round + 1)
    championship.favorite_golfer = previous_winners_bracket.first.winner_golfer
    championship.underdog_golfer = previous_winners_bracket.last.winner_golfer
    championship.favorite_seed = previous_winners_bracket.first.winner_seed
    championship.underdog_seed = previous_winners_bracket.last.winner_seed
    championship.winner_place = 1
    championship.loser_place = 2
    return false unless championship.save
    
    # Make 3rd Place Game
    third_place = MatchPlayMatchup.new(season_tournament_id: self.id, round: current_round + 1)
    third_place.favorite_golfer = previous_winners_bracket.first.loser_golfer
    third_place.underdog_golfer = previous_winners_bracket.last.loser_golfer
    third_place.favorite_seed = previous_winners_bracket.first.loser_seed
    third_place.underdog_seed = previous_winners_bracket.last.loser_seed
    third_place.winner_place = 3
    third_place.loser_place = 4
    return false unless third_place.save
    
    # Make 5th Place Game
    fifth_place = MatchPlayMatchup.new(season_tournament_id: self.id, round: current_round + 1)
    fifth_place.favorite_golfer = previous_losers_bracket.first.winner_golfer
    fifth_place.underdog_golfer = previous_losers_bracket.last.winner_golfer
    fifth_place.favorite_seed = previous_losers_bracket.first.winner_seed
    fifth_place.underdog_seed = previous_losers_bracket.last.winner_seed
    fifth_place.winner_place = 5
    fifth_place.loser_place = 6
    return false unless fifth_place.save
    
    # Make 7th Place Game
    seventh_place = MatchPlayMatchup.new(season_tournament_id: self.id, round: current_round + 1)
    seventh_place.favorite_golfer = previous_losers_bracket.first.loser_golfer
    seventh_place.underdog_golfer = previous_losers_bracket.last.loser_golfer
    seventh_place.favorite_seed = previous_losers_bracket.first.loser_seed
    seventh_place.underdog_seed = previous_losers_bracket.last.loser_seed
    seventh_place.winner_place = 7
    seventh_place.loser_place = 8
    return false unless seventh_place.save
    true
  end
  
end