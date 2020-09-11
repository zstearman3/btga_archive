class Golfer < ApplicationRecord
  belongs_to :society
  has_many :golfer_seasons, dependent: :destroy
  has_many :golfer_events, dependent: :destroy
  validates :name, presence: true
  
  def formatted_handicap
    if handicap < 0
     "+ #{handicap.abs.to_s}"
    else
      handicap.to_s
    end
  end
end
