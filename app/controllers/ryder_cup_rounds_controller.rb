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
      flash[:success] = "Round added!"
      redirect_to @session
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
    def round_params
      params.require(:ryder_cup_round).permit(:europe_golfer_one_id, :europe_golfer_two_id, :usa_golfer_one_id,
                     :usa_golfer_two_id, :usa_score, :europe_score, :usa_points, :europe_points)
    end
end
