class CreateGolferRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :golfer_rounds do |t|
      t.integer :round_order
      t.integer :score
      t.integer :score_to_par
      t.belongs_to :golfer
      t.belongs_to :golfer_event
      t.belongs_to :course
      t.belongs_to :tournament
      t.belongs_to :season_tournament
      t.belongs_to :society
      t.timestamps
    end
  end
end
