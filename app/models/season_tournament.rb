class SeasonTournament < ApplicationRecord
  belongs_to :society
  belongs_to :tournament
  belongs_to :season
  belongs_to :course
  has_many :event_winners
  has_many :golfers, through: :event_winners
  has_many :golfer_events, dependent: :destroy
  has_many :golfer_rounds, dependent: :destroy
  validates :season_order, numericality: { only_integer: true }
  validates_uniqueness_of :season_id, scope: %i[tournament_id]
  validates_uniqueness_of :start_date, scope: %i[season_id]
  
  def tournament_name
    tournament.name
  end
  
  def course_name
    course.name
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
    golfer_events.each do |event|
      event.calculate_finish
      event.calculate_points
      event.save
      if event.finish == 1
        event_winner = EventWinner.new(golfer: event.golfer, season_tournament: self)
        event_winner.save
        event.golfer.update_victory_count
      end
    end
    season.golfer_seasons.each { |season| season.update_season }
    self.finalized = true
  end
  
  def unfinalize_event
    event_winners.destroy_all
    self.finalized = false
    self.save
  end
  
  def select_default_course
    @course = Tournament.find(params[:id]).course
  end
end