class SeasonTournamentsController < ApplicationController
  def index
    @events = SeasonTournament.all
  end
  
  def show; end
    
  def new
    @event = SeasonTournament.new
  end
  
  def create
    @event = SeasonTournament.new(event_params)
    @event.society = Society.last
    @event.season_order = SeasonTournament.where(season_id: @event.season_id).where("start_date < ?", @event.start_date).count + 1
    if @event.save
      flash[:success] = "Event added!"
      redirect_to schedule_path(params[:season])
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
    @season = Season.includes(season_tournaments: [:tournament, :course]).friendly.find(params[:id])
    @events = @season.season_tournaments.order(:season_order)
  end
  
  private
  
    def select_event
      begin
        @event = SeasonTournament.find(params[:id])
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
