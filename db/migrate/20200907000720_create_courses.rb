class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      
      t.string :name
      t.integer :yardage
      t.integer :par
      t.string :difficulty
      t.timestamps
    end
  end
end
