class TournamentLevel < ApplicationRecord
  has_many :tournaments
  validates :name, presence: true
end
