class Golfer < ApplicationRecord
  belongs_to :society
  validates :name, presence: true
end
