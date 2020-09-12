class Society < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :golfers, dependent: :destroy
  has_many :golfer_seasons, dependent: :destroy
  has_many :tournaments, dependent: :destroy
  has_many :season_tournaments, dependent: :destroy
  has_many :golfer_events, dependent: :destroy
  has_many :golfer_rounds, dependent: :destroy
end
