class RyderCupsController < ApplicationController
  def show
    @season = Season.find_by(year: params[:id])
    @ryder_cup = RyderCup.includes(:team_europe, :team_usa, :ryder_cup_sessions).find_by(season_id: @season.id)
    @sessions = @ryder_cup.ryder_cup_sessions.order(:order)
    @team_europe = @ryder_cup.team_europe
    @team_usa = @ryder_cup.team_usa
    @champion = @ryder_cup.champion
  end
end
