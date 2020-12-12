class Tournament < ApplicationRecord
  belongs_to :society
  belongs_to :tournament_level
  belongs_to :course, optional: true
  has_many :season_tournaments, dependent: :destroy
  has_many :golfer_events
  has_many :golfer_rounds
  validates :name, uniqueness: true
  
  def home_course
    course ? course.name : 'Rotates'
  end
  
  def level
    tournament_level.name if tournament_level
  end
  
  def latest_name
    updated_name ? updated_name : name
  end
  
  def current_name(year)
    if updated_name.nil?
      name
    elsif year < name_updated_year
      name
    else
      updated_name
    end
  end
  
  def best_rounds
    record = []
    low_score = golfer_rounds.order(score: :asc).first.score if golfer_rounds.count > 0
    rounds = golfer_rounds.where("score = ?", low_score)
    rounds.each do |round|
      new_round = {}
      new_round[:golfer] = round.golfer.name
      new_round[:score] = low_score
      new_round[:score_to_par] = round.display_score_to_par
      new_round[:event] = round.season_tournament.tournament_name_with_year
      new_round[:course] = round.course.name
      new_round[:golfer_id] = round.golfer.id
      new_round[:event_id] = round.season_tournament.id
      new_round[:course_id] = round.course.id
      record << new_round
    end
    record
  end
  
  def best_tournaments
    record = []
    low_score = golfer_events.order(score_to_par: :asc).first.score_to_par if golfer_events.count > 0
    tournaments = golfer_events.where("score_to_par = ?", low_score)
    tournaments.each do |tournament|
      new_tournament = {}
      new_tournament[:golfer] = tournament.golfer.name
      new_tournament[:score] = tournament.score
      new_tournament[:score_to_par] = tournament.display_score_to_par
      new_tournament[:event] = tournament.season_tournament.tournament_name_with_year
      new_tournament[:course] = tournament.course.name
      new_tournament[:golfer_id] = tournament.golfer.id
      new_tournament[:event_id] = tournament.season_tournament.id
      new_tournament[:course_id] = tournament.course.id
      record << new_tournament
    end
    record
  end
  
  def winners
    events = []
    season_tournaments.order(start_date: :desc).each do |tournament|
      event = {}
      event[:id] = tournament.id
      event[:year] = tournament.year
      event[:winners] = tournament.display_winners
      event[:score] = tournament.winning_score
      event[:score_to_par] = tournament.winning_score_to_par
      event[:course] = tournament.course_name
      event[:course_id] = tournament.course.id
      events << event
    end
    events
  end
  
end
