class Tournament < ApplicationRecord
  belongs_to :society
  belongs_to :tournament_level
  belongs_to :course, optional: true
  has_many :season_tournaments, dependent: :destroy
  has_many :golfer_events, dependent: :destroy
  validates :name, uniqueness: true
  
  def home_course
    course ? course.name : 'Rotates'
  end
  
  def level
    tournament_level.name if tournament_level
  end
end
