class TournamentsController < ApplicationController
  
  def index
    @tournaments = Tournament.all.order(:name)
  end
  
  def show; end
    
  def new
    @tournament = Tournament.new
  end
  
  def create
    @tournament = Tournament.new(tournament_params)
    @tournament.society = Society.last
    if @tournament.save
      flash[:success] = "Tournament added!"
      redirect_to tournaments_path
    else
      render 'new'
    end
  end
  
  def edit; end
    
  def update
  
  end
  
  def destroy
  
  end
  
  private
    def select_tournament
      
    end
    
    def tournament_params
      params.require(:tournament).permit(:name, :society_id, :course_id)
    end
    
end
