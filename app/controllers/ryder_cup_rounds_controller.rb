class RyderCupRoundsController < ApplicationController
  def new
    @session = RyderCupSession.find(params[:ryder_cup_session_id])
    @round = RyderCupRound.new
    @europe = @session.ryder_cup.team_europe.golfers
    @usa = @session.ryder_cup.team_usa.golfers
  end
  
  def create
    @session = RyderCupSession.find(params[:ryder_cup_session_id])
    @round = @session.ryder_cup_rounds.new(round_params)
    @europe = @session.ryder_cup.team_europe.golfers
    @usa = @session.ryder_cup.team_usa.golfers
    if @round.save
      @round.calculate_points
      flash[:success] = "Round added!"
      redirect_to @session
    else
      render 'new'
    end
  end
  
  def edit
    @session = RyderCupSession.find(params[:ryder_cup_session_id])
    @round = @session.ryder_cup_rounds.find(params[:id])
    @europe = @session.ryder_cup.team_europe.golfers
    @usa = @session.ryder_cup.team_usa.golfers
  end
  
  def update
    @session = RyderCupSession.find(params[:ryder_cup_session_id])
    @round = @session.ryder_cup_rounds.find(params[:id])
    if @round.update(round_params)
      @round.calculate_points
      @session.team_europe_score = @session.ryder_cup_rounds.sum(:europe_points)
      @session.team_usa_score = @session.ryder_cup_rounds.sum(:usa_points)
      @session.save
      flash['success'] = "Round updated!"
      redirect_to @session
    else
      render 'edit'
    end
  end
  
  def destroy
    @session = RyderCupSession.find(params[:ryder_cup_session_id])
    @round = @session.ryder_cup_rounds.find(params[:id])
    @round.destroy ? flash[:success] = "Round deleted!" : flash[:warning] = "There was a problem deleting the round!"
    redirect_to @session
  end
  
  private
    def round_params
      params.require(:ryder_cup_round).permit(:europe_golfer_one_id, :europe_golfer_two_id, :usa_golfer_one_id,
                     :usa_golfer_two_id, :usa_score, :europe_score, :usa_points, :europe_points)
    end
end
