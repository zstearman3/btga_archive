class RyderCupTeam < ApplicationRecord
  has_many :ryder_cup_appearances
  has_many :golfers, through: :ryder_cup_appearances
end
