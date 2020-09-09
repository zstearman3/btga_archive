class Course < ApplicationRecord
  validates :star_rating, numericality: { less_than_or_equal_to: 10, greater_than_or_equal_to: 0, allow_nil: true }
  validates :name, uniqueness: true
  validates :name, presence: true

  def self.difficulty_options
    ['Easiest', 'Easy', 'Medium', 'Hard', 'Hardest']
  end
  
end
