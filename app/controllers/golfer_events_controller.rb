class GolferEventsController < ApplicationController
  def index; end
    
  def show; end
    
  def new
    @season_tournament = SeasonTournament.includes(:season).find(params[:season_tournament_id])
    @season = @season_tournament.season
    @golfer_event = @season_tournament.golfer_events.build
  end
  
  def create
    @season_tournament = SeasonTournament.find(params[:season_tournament_id])
    @golfer_event = @season_tournament.golfer_events.new(event_params)
    @golfer_event.society = Society.last
    @golfer_season = GolferSeason.find_or_create_by(golfer: @golfer_event.golfer, season: @season_tournament.season)
    @golfer_event.golfer_season = @golfer_season
    @golfer_event.tournament = @season_tournament.tournament
    @golfer_event.course = @season_tournament.course
    @golfer_event.score_to_par = @golfer_event.calculate_score_to_par
    if @golfer_event.save
      @golfer_season.society = @golfer_event.society
      @golfer_season.save
      flash[:success] = "Tournament logged!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  private
  
    def event_params
      params.require(:golfer_event).permit(:completed, :finish, :score, :score_to_par,
                     :points, :golfer_id, :golfer_season_id, :tournament_id, :society_id)
    end
end
