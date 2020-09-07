class Course < ApplicationRecord
  validates :star_rating, :inclusion => 1..10

  def self.difficulty_options
    ['Easiest', 'Easy', 'Medium', 'Hard', 'Hardest']
  end
  
end
