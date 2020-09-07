class AddStarRatingToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :star_rating, :decimal
  end
end
