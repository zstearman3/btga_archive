class RyderCupSession < ApplicationRecord
  ALLOWED_TYPES = ["Fourball", "Foursome", "Singles"]
  belongs_to :ryder_cup
  validates :scoring_type, :inclusion => { :in => ALLOWED_TYPES }
end
