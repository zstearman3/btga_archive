require 'pry'
class MatchPlayMatchupsController < ApplicationController
  def edit
    @match = MatchPlayMatchup.find(params[:id])
  end
  
  def update
    @match = MatchPlayMatchup.find(params[:id])
    @match.assign_attributes(match_params)
    @match.loser_golfer_id =
      if @match.winner_golfer_id == @match.favorite_golfer_id
        @match.underdog_golfer_id
      else
        @match.favorite_golfer_id
      end
    if @match.save
      flash[:success] = "Results saved!"
      redirect_to match_play_path(@match.season_tournament_id)
    else
      render 'edit'
    end
  end
  
  private
  
    def match_params
      params.require(:match_play_matchup).permit(:strokes_up, :holes_to_play, :winner_golfer_id, :loser_golfer_id,
                                          :favorite_golfer_id, :underdog_golfer_id)
    end
end
