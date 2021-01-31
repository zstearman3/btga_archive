module PointsCalculator
  
  def calculate_season_points year
    return unless year.respond_to?(:to_i)
    seasons = GolferSeason.includes(:golfer_events)
                          .joins(:season).where("seasons.year = ?", year)
    seasons.each do |s|
      print s.golfer_events.inspect
    end
  end
  
end