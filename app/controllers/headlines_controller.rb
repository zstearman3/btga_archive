class HeadlinesController < ApplicationController
  
  def new
    @headline = Headline.new
  end
  
  def create
    @headline = Headline.new(headline_params)
    @headline.expiration_date = @headline.get_expiration_date
    @headline.society = Society.last
    if @headline.save
      flash[:success] = "Headline added!"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def destroy
    @headline = Headline.find(params[:id])
    @headline.destroy ? flash[:success] = "Headline deleted!" : flash[:danger] = "There was a problem deleting the headline!"
    redirect_to root_url
  end
  
  private
  
    def headline_params
      params.require(:headline).permit(:story, :importance, :creation_date, :expiration_date, 
                     :golfer_id, :season_tournament_id, :society_id)
    end
end
