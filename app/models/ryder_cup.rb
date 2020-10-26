class RyderCup < ApplicationRecord
  has_many :ryder_cup_sessions, dependent: :destroy
  belongs_to :team_europe, :class_name => :RyderCupTeam, :foreign_key => "team_europe_id"
  belongs_to :team_usa, :class_name => :RyderCupTeam, :foreign_key => "team_usa_id"
  belongs_to :champion, :class_name => :RyderCupTeam, :foreign_key => "champion", optional: true
  belongs_to :season
  validates_uniqueness_of :season_id
  
  def self.generate(season_id, europe_array, usa_array)
    # Requires array of Golfer objects with captains first in order
    r = RyderCup.new(season_id: season_id)
    e = RyderCupTeam.create!(name: "Team Europe")
    u = RyderCupTeam.create!(name: "Team USA")
    i = 0
    europe_array.each do |golfer|
      if i == 0
        RyderCupAppearance.create!(golfer: golfer, ryder_cup_team: e, captain: true)
      else
        RyderCupAppearance.create!(golfer: golfer, ryder_cup_team: e, captain: false)
      end
      i += 1
    end
    i = 0
    usa_array.each do |golfer|
      if i == 0
        RyderCupAppearance.create!(golfer: golfer, ryder_cup_team: u, captain: true)
      else
        RyderCupAppearance.create!(golfer: golfer, ryder_cup_team: u, captain: false)
      end
    end
    r.team_europe = e
    r.team_usa = u
    r.save
  end
  
  def generate_sessions
    RyderCupSession.create(ryder_cup_id: id, order: 1, scoring_type: "Scramble")
    RyderCupSession.create(ryder_cup_id: id, order: 2, scoring_type: "Fourball")
    RyderCupSession.create(ryder_cup_id: id, order: 3, scoring_type: "Scramble")
    RyderCupSession.create(ryder_cup_id: id, order: 4, scoring_type: "Foursome")
    RyderCupSession.create(ryder_cup_id: id, order: 5, scoring_type: "Singles")
  end
  
  def president_or_ryder
    name ? name : "Ryder Cup"
  end
  
  def display_name
    "#{season.year} #{president_or_ryder}"
  end
  
  def europe_score
    ryder_cup_sessions.sum(:team_europe_score)
  end
  
  def usa_score
    ryder_cup_sessions.sum(:team_usa_score)
  end
  
end
