class SeasonsController < ApplicationController
  before_action :select_season, only: [:show]
  
  def index
    @seasons = Season.all
  end
  
  def show
    @seasons = @season.golfer_seasons.order(points: :desc)
  end
  
  private
  
    def select_season
      begin
        @season = Season.includes(:golfer_seasons).find(params[:id])
      rescue StandardError => e
        redirect_to schedule_path(Season.current_year)
        flash[:danger] = e.message
      end
    end
end
