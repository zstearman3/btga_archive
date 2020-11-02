class Season < ApplicationRecord
  CURRENT_YEAR = 2022
  CURRENT_ID = 3
  
  extend FriendlyId
  belongs_to :society
  belongs_to :champion, :class_name => :Golfer, :foreign_key => "champion_id", optional: true
  has_one :ryder_cup
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
  
  def next_event
    season_tournaments.where("start_date > ?", Date.today - 1.day).order(:start_date).first
  end
  
  def champion_name
    if champion
      champion.name
    else
      "N/A"
    end
  end
  
  def finalize
    self.champion = golfer_seasons.order(:points).last.golfer
    self.save
  end
end
