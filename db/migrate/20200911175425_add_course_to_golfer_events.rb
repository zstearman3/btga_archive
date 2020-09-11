class AddCourseToGolferEvents < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :golfer_events, :course
  end
end
