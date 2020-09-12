class GolferSeason < ApplicationRecord
  belongs_to :society
  belongs_to :season
  belongs_to :golfer
  has_many :golfer_events, dependent: :destroy
  has_many :golfer_rounds, dependent: :destroy
  
  def name
    golfer.name
  end
end
