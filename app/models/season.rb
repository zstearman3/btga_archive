class Season < ApplicationRecord
  CURRENT_YEAR = 2020
  CURRENT_ID = 1
  
  extend FriendlyId
  belongs_to :society
  has_many :golfer_seasons, dependent: :destroy
  has_many :season_tournaments, -> { order(:season_order) }, dependent: :destroy
  validates_uniqueness_of :year, scope: %i[society_id]
  friendly_id :year, use: [:slugged, :finders]
  
  def self.current_year
    CURRENT_YEAR
  end
  
  def self.current_id
    CURRENT_ID
  end
  
  def current_event
    season_tournaments.where("start_date < ?", Date.today).order(:start_date).last
  end
end
