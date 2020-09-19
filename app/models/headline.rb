class Headline < ApplicationRecord
  belongs_to :golfer, optional: true
  belongs_to :season_tournament, optional: true
  belongs_to :society
  validates_inclusion_of :importance, :in => self.importance_options
  validates :story, presence: true
  validates :creation_date, presence: true
  validates :expiration_date, presence: true
  
  def self.importance_options
    ['Low', 'Medium', 'High']
  end
  
  def get_expiration_date
    if importance == "Low"
      creation_date + 3.days
    elsif importance == "Medium"
      creation_date + 5.days
    elsif importance == "High"
      creation_date + 7.days
    end
  end
  
end
