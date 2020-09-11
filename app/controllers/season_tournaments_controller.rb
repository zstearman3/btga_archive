class SeasonTournamentsController < ApplicationController
  before_action :select_event, only: [:show, :edit, :update, :destroy]
  
  def index
    @events = SeasonTournament.all
  end
  
  def show
    @golfer_events = @event.golfer_events.includes(:golfer).order(:finish)  
  end
    
  def new
    @event = SeasonTournament.new
  end
  
  def create
    @event = SeasonTournament.new(event_params)
    @event.society = Society.last
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
  
  end
  
  def destroy
  
  end
  
  def schedule
    @season = Season.includes(season_tournaments: [:tournament, :course]).find(params[:id])
    @events = @season.season_tournaments
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
                                        :course_id, :society_id, :tournament_id, :season_id)
    end
end
