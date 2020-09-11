class CreateGolferEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :golfer_events do |t|
      t.boolean :completed
      t.integer :finish
      t.integer :score
      t.integer :score_to_par
      t.integer :points
      t.belongs_to :golfer
      t.belongs_to :golfer_season
      t.belongs_to :tournament
      t.belongs_to :season_tournament
      t.belongs_to :society
      t.timestamps
    end
  end
end
