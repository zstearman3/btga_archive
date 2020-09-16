class RyderCupsController < ApplicationController
  def show
    @season = Season.find_by(year: params[:id])
    @ryder_cup = RyderCup.includes(:team_europe, :team_usa).find_by(season_id: @season.id)
    @team_europe = @ryder_cup.team_europe
    @team_usa = @ryder_cup.team_usa
  end
end
