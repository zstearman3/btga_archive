class Society < ApplicationRecord
  has_many :seasons, dependent: :destroy
end
