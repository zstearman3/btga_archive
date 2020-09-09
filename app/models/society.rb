class Society < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :golfers, dependent: :destroy
end
