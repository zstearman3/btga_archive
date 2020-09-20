class GolferEventsController < ApplicationController
  before_action :select_golfer_event, only: [:show, :edit, :update, :destroy]
  
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
    @golfer_event.golfer_season= @golfer_season
    @golfer_event.tournament = @season_tournament.tournament
    @golfer_event.course = @season_tournament.course
    if @golfer_event.completed
      for i in 1..@season_tournament.rounds
        new_round = GolferRound.new(golfer_event: @golfer_event)
        new_round.init_from_event(i, params[:golfer_event][:"round_#{i}_score"].to_i)
        if !new_round.save
          raise "Round #{i} was not saved: #{new_round.inspect}"
        end
      end
      @golfer_event.score = 0
      @golfer_event.golfer_rounds.each { |round| @golfer_event.score += round.score }
      @golfer_event.score_to_par = @golfer_event.calculate_score_to_par
    end
    if @golfer_event.save
      @season_tournament.golfer_events.each do |event|
        event.finish = event.calculate_finish
        event.save
      end
      @golfer_season.society = @golfer_event.society
      @golfer_season.save
      flash[:success] = "Tournament logged!"
      redirect_to @season_tournament
    else
      render 'new'
    end
  end
 
  def edit
    @season = @season_tournament.season
    for i in 1..@golfer_event.golfer_rounds.count
      @golfer_event.set_round_accessor_score(i)
    end
  end
  
  def update
    @golfer_event.assign_attributes(event_params)
    if @golfer_event.completed
      for i in 1..@season_tournament.rounds
        round = @golfer_event.golfer_rounds.find_or_create_by(round_order: i)
        round.init_from_event(i, params[:golfer_event][:"round_#{i}_score"].to_i)
        if !round.save
          raise "Round #{i} was not saved: #{new_round.inspect}"
        end
      end
      @golfer_event.score = 0
      @golfer_event.golfer_rounds.each { |round| @golfer_event.score += round.score }
      @golfer_event.score_to_par = @golfer_event.calculate_score_to_par
    end
    if @golfer_event.save
      @season_tournament.golfer_events.each do |event|
        event.finish = event.calculate_finish
        event.save
      end
      flash[:success] = "Tournament logged!"
      redirect_to @season_tournament
    else
      render 'edit'
    end
  end
  
  def destroy
    if @golfer_event.destroy 
      @season_tournament.golfer_events.each do |event|
        event.finish = event.calculate_finish
        event.save
      end
      flash[:success] = "Event deleted!" 
    else
      flash[:danger] = "There was a problem deleting the event!"
    end
    redirect_to @season_tournament
  end
  
  private
  
    def select_golfer_event
      begin
        @season_tournament = SeasonTournament.find(params[:season_tournament_id])
        @golfer_event = GolferEvent.find(params[:id])
      rescue StandardError => e
        redirect_to season_tournament_path(params[:season_tournament_id])
        flash[:danger] = e.message
      end
    end
    
    def event_params
      params.require(:golfer_event).permit(:completed, :finish, :score, :score_to_par,
                     :points, :golfer_id, :golfer_season_id, :tournament_id, :society_id)
    end
end
