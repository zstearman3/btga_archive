class CreateGolferSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :golfer_seasons do |t|
      t.integer :year
      t.integer :events
      t.integer :wins
      t.integer :points
      t.boolean :champion
      t.belongs_to :golfer
      t.belongs_to :season
      t.belongs_to :society
      t.timestamps
    end
  end
end
