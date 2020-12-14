class MatchPlayMatchup < ApplicationRecord
  belongs_to :favorite_golfer, class_name: :Golfer, foreign_key: "favorite_golfer_id"
  belongs_to :underdog_golfer, class_name: :Golfer, foreign_key: "underdog_golfer_id"
  belongs_to :winner_golfer, class_name: :Golfer, foreign_key: "winner_golfer_id", optional: true
  belongs_to :loser_golfer, class_name: :Golfer, foreign_key: "loser_golfer_id", optional: true
  
  def result_string
    if winner_golfer
      "#{winner_golfer.name} - #{strokes_up}&#{holes_to_play}"
    else
      "Edit"
    end
  end
  
  def winner_seed
    return nil unless winner_golfer 
    if winner_golfer == favorite_golfer
      favorite_seed
    else
      underdog_seed
    end
  end
  
  def loser_seed
    return nil unless winner_golfer 
    if winner_golfer == favorite_golfer
      underdog_seed
    else
      favorite_seed
    end
  end
  
end
