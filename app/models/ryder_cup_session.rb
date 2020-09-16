class RyderCupSession < ApplicationRecord
  ALLOWED_TYPES = ["Fourball", "Foursome", "Singles"]
  has_many :ryder_cup_rounds, dependent: :destroy
  belongs_to :ryder_cup
  belongs_to :course, optional: true
  validates :scoring_type, :inclusion => { :in => ALLOWED_TYPES }
  
  def name
    "#{ryder_cup.season.year} #{scoring_type}"
  end
end
