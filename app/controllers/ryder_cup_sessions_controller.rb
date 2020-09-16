class RyderCupSessionsController < ApplicationController
  def show
    @session = RyderCupSession.includes(:ryder_cup_rounds).find(params[:id])
    @rounds = @session.ryder_cup_rounds
  end
end
