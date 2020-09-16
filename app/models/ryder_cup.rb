class RyderCup < ApplicationRecord
  belongs_to :team_europe, :class_name => :RyderCupTeam, :foreign_key => "team_europe_id", dependent: :destroy
  belongs_to :team_usa, :class_name => :RyderCupTeam, :foreign_key => "team_usa_id", dependent: :destroy
  belongs_to :champion, :class_name => :RyderCupTeam, :foreign_key => "champion_id", optional: true
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
  
  def name
    "#{season.year} Ryder Cup"
  end
  
end
