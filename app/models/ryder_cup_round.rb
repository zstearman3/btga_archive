class RyderCupRound < ApplicationRecord
  belongs_to :ryder_cup_session
  belongs_to :europe_golfer_one, :class_name => :Golfer, :foreign_key => "europe_golfer_one_id" 
  belongs_to :europe_golfer_two, :class_name => :Golfer, :foreign_key => "europe_golfer_two_id", optional: true
  belongs_to :usa_golfer_one, :class_name => :Golfer, :foreign_key => "usa_golfer_one_id"
  belongs_to :usa_golfer_two, :class_name => :Golfer, :foreign_key => "usa_golfer_two_id", optional: true

  def usa_golfers
    if usa_golfer_two
      "#{usa_golfer_one.name}/#{usa_golfer_two.name}"
    else
      usa_golfer_one.name
    end
  end
  
  def europe_golfers
    if europe_golfer_two
      "#{europe_golfer_one.name}/#{europe_golfer_two.name}"
    else
      europe_golfer_one.name
    end
  end
  
  def calculate_points
    if europe_score && usa_score
      if europe_score > usa_score
        self.usa_points = 0
        self.europe_points = 1
      elsif usa_score > europe_score
        self.usa_points = 1
        self.europe_points = 0
      else
        self.usa_points = 0.5
        self.europe_points = 0.5
      end
      self.save
    end
  end
end
