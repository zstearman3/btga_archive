class CreateRyderCupRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :ryder_cup_rounds do |t|
      t.belongs_to :ryder_cup_session
      t.integer :europe_golfer_one_id
      t.integer :europe_golfer_two_id
      t.integer :usa_golfer_one_id
      t.integer :usa_golfer_two_id
      t.integer :europe_score
      t.integer :usa_score
      t.integer :europe_points
      t.integer :usa_points
      t.timestamps
    end
  end
end
