class Headline < ApplicationRecord
  IMPORTANCE_OPTIONS = ['Low', 'Medium', 'High']
  belongs_to :golfer, optional: true
  belongs_to :season_tournament, optional: true
  belongs_to :society
  validates_inclusion_of :importance, :in => IMPORTANCE_OPTIONS
  validates :story, presence: true
  validates :story_date, presence: true
  validates :expiration_date, presence: true
  
  def self.importance_options
    IMPORTANCE_OPTIONS
  end
  
  def get_expiration_date
    if importance == "Low"
      story_date + 3.days
    elsif importance == "Medium"
      story_date + 5.days
    elsif importance == "High"
      story_date + 7.days
    end
  end
  
  def generate_event_winner_story(golfer, tournament, score)
    templates = [ "#{golfer} has won the #{tournament} with a score of #{score}!",
                  "#{golfer} shoots #{score} to win the #{tournament}!",
                  "#{golfer} won the #{tournament} by shooting an impressive #{score}!"
      ]
      self.story = templates.sample
      self.society = Society.last
      self.importance = "Low"
      self.story_date = Date.today
      self.expiration_date = get_expiration_date
      self.save
  end
end
