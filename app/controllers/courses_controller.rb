class CoursesController < ApplicationController
  before_action :select_course, only: [:show, :edit, :update, :destroy]
  
  def index
    @courses = Course.all.order(:name)
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
  
  def edit; end
    
  def update
    if @course.update(course_params)
      flash['success'] = "Course updated!"
      redirect_to courses_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @course.destroy ? flash[:success] = "Course deleted!" : flash[:danger] = "There was a problem deleting the course."
    redirect_to courses_path
  end
  
  private
  
    def select_course
      begin
        @course = Course.find(params[:id])
      rescue StandardError => e
        redirect_to courses_path
        flash[:danger] = e.message
      end
    end
    
    def course_params
      params.require(:course).permit(:name, :yardage, :par, :difficulty, :star_rating)
    end
  
end
