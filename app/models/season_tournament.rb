class SeasonTournament < ApplicationRecord
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
    if tournament.tournament_level_id == 1
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
    elsif tournament.tournament_level_id == 2
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
    elsif tournament.tournament_level_id == 3
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
    else
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
    end
    true
  end
  
  def unfinalize_event
    event_winners.destroy_all
    headlines.destroy_all
    golfer_events.each do |event|
      event.points = 0
      event.save
    end
    season.golfer_seasons.each { |g| g.update_season }
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
  end
  
  def match_semi_finals
    previous_matchups = self.match_play_matchups.where(round: 1).order(favorite_seed: :asc)
    return false if previous_matchups.where(winner_golfer: nil).count > 0 
    2.times do |n|
      winner_matchup = MatchPlayMatchup.new()
      winner_matchup.favorite_golfer = previous_matchups[n].winner_golfer
      winner_matchup.underdog_golfer = previous_matchups[ 3 - n].winner_golfer
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
  end
  
end