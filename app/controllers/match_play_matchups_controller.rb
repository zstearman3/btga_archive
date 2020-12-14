class MatchPlayMatchupsController < ApplicationController
  def edit
    @match = MatchPlayMatchup.find(params[:id])
  end
  
  def update
    @match = MatchPlayMatchups.find(params[:id])
  end
end
