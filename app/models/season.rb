class Season < ApplicationRecord
  CURRENT_YEAR = 2020
  
  extend FriendlyId
  belongs_to :society
  has_many :season_tournaments, dependent: :destroy
  validates_uniqueness_of :year, scope: %i[society_id]
  friendly_id :year, use: [:slugged, :finders]
  
  def self.current_year
    CURRENT_YEAR
  end
  
end
