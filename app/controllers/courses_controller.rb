class CoursesController < ApplicationController
  
  def index
    @courses = Course.all
  end
  
  def show; end
  
  def new
    @course = Course.new
  end
  
  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:success] = "Course added!"
      redirect_to courses_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  private
  
    def course_params
      params.require(:course).permit(:name, :yardage, :par, :difficulty)
    end
  
end
