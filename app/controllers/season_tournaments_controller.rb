class SeasonTournamentsController < ApplicationController
  before_action :select_event, only: [:show, :edit, :update, :destroy, :finalize, :unfinalize, :match_play, :generate_matchups]
  
  def index
    @events = SeasonTournament.all
  end
  
  def show
    @golfer_events = @event.golfer_events.includes(:golfer).order(:finish)  
  end
    
  def new
    @event = SeasonTournament.new
    @season = Season.find_by(year: params[:season])
    @season_id = @season.id if @season
  end
  
  def create
    @event = SeasonTournament.new(event_params)
    @event.society = Society.last
    @event.event_level = @event.tournament.tournament_level.name.downcase
    @event.season_order = SeasonTournament.where(season_id: @event.season_id).where("start_date < ?", @event.start_date).count + 1
    if @event.save
      flash[:success] = "Event added!"
      redirect_to schedule_path(@event.season.year)
    else
      render 'new'
    end
  end
  
  def edit; end
    
  def update
    if @event.update(event_params)
      flash['success'] = "Event updated!"
      redirect_to schedule(@event.season.year)
    else
      render 'edit'
    end
  end
  
  def destroy
    @event.destroy ? flash[:success] = "Event deleted!" : flash[:danger] = "There was a problem deleting the event!"
    redirect_to schedule(@event.season.year)
  end
  
  def schedule
    @season = Season.includes(season_tournaments: [:tournament, :course]).find(params[:id])
    @previous_season = Season.find_by(year: @season.year - 1)
    @next_season = Season.find_by(year: @season.year + 1)
    @events = @season.season_tournaments
  end
  
  def match_play
    @round_one_matchups = @event.match_play_matchups.where(round: 1)  
  end
  
  def generate_matchups
    if @event.generate_matchups == true
      flash[:success] = "Matchups Created!"
      redirect_to match_play_path(@event)
    else
      flash[:warning] = "Matchups could not be generated. Please make sure there are at least 8 eligible players!"
      redirect_to match_play_path(@event)
    end
  end
  
  def finalize
    @event.finalize_event ? flash[:success] = "Event finalized!": flash[:warning] = "Event not finalized!"
    redirect_to @event
  end
  
  def unfinalize
    @event.unfinalize_event ? flash[:success] = "Event unfinalized!": flash[:warning] = "Error unfinalizing event!"
    redirect_to @event
  end
  
  private
  
    def select_event
      begin
        @event = SeasonTournament.includes(:tournament).find(params[:id])
      rescue StandardError => e
        redirect_to schedule_path(Season.current_year)
        flash[:danger] = e.message
      end
    end
    
    def event_params
      params.require(:season_tournament).permit(:season_order, :rounds, :start_date, :end_date, 
                                        :course_id, :society_id, :tournament_id, :season_id, :match_play)
    end
end
