class GolfersController < ApplicationController
  
  def index
    @golfers = Golfer.all
  end
  
  def show; end
  
  def new
    @golfer = Golfer.new
  end
  
  def create
    @golfer = Golfer.new(golfer_params)
    @golfer.society = Society.last
    if @golfer.save
      flash[:success] = "Golfer added!"
      redirect_to roster_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  private
  
    def golfer_params
      params.require(:golfer).permit(:name, :gamertag, :handicap, :victories, :society_id)
    end
  
end
