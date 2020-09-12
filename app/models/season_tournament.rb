class SeasonTournament < ApplicationRecord
  belongs_to :society
  belongs_to :tournament
  belongs_to :season
  belongs_to :course
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
  
  def finalize_event
    golfer_events.each do |event|
      event.calculate_finish
      event.save
    end
    self.finalized = true
  end
end