module ScoreToPar
  
  def self.convert_score_to_par(score, par)
    if score - par > 0
      "+ #{score - par}"
    elsif score - par == 0
      "E"
    else 
      (score - par).to_s
    end
  end
  
end