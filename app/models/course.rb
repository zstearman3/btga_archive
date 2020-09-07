class Course < ApplicationRecord

  def self.difficulty_options
    ['Easiest', 'Easy', 'Medium', 'Hard', 'Hardest']
  end
  
end
