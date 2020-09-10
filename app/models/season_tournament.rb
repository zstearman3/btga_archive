class SeasonTournament < ApplicationRecord
  belongs_to :society
  belongs_to :tournament
  belongs_to :season
  belongs_to :course
  validates :season_order, numericality: { only_integer: true }
  validates_uniqueness_of :season_id, scope: %i[tournament_id]
  validates_uniqueness_of :start_date, scope: %i[season_id]
  
  def tournament_name
    tournament.name
  end
end