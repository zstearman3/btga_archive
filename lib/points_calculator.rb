require 'pry'
module PointsCalculator
  
  def calculate_season_points year
    return unless year.respond_to?(:to_i)
    seasons = GolferSeason.includes(:golfer_events)
                          .joins(:season).where("seasons.year = ?", year)
    event_count = SeasonTournament.joins(:season)
                                  .where("seasons.year = ?",  year)
                                  .where(finalized: true).count
    seasons.each do |s|
      events = s.golfer_events.to_a
      points = _calculate_points events, event_count
      s.update(points: points)
    end
  end
  
  private
  
  def _calculate_points events, event_count
    binding.pry
    events = events.sort_by{ |event| event.points }.reverse
    case event_count
    when 0..4
      events.map {|e| e[:points]}.sum
    when 5..9
      counted_events = event_count - 1
      events.first(counted_events).map {|e| e[:points]}.sum
    when 10..19
      counted_events = event_count - 2
      events.first(counted_events).map {|e| e[:points]}.sum
    else
      counted_events = event_count - 3
      events.first(counted_events).map {|e| e[:points]}.sum
    end
  end
end