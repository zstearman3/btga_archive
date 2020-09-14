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
  
  def finalize_event
    golfer_events.each do |event|
      event.calculate_finish
      event.save
      if event.finish == 1
        event_winner = EventWinner.new(golfer: event.golfer, season_tournament: self)
        event_winner.save
        event.golfer.update_victory_count
      end
    end
    self.finalized = true
  end
  
  def unfinalize_event
    event_winners.destroy_all
    self.finalized = false
    self.save
  end
end