class Tournament < ApplicationRecord
  belongs_to :society
  belongs_to :course, optional: true
  validates :name, uniqueness: true
  
  def self.type_options
    ['Tournament', 'Major', 'Championship']  
  end
  
  def home_course
    course ? course.name : 'Rotates'
  end
end
