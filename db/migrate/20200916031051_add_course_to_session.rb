class AddCourseToSession < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :ryder_cup_sessions, :course
  end
end
