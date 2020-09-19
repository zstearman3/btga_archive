class CreateHeadlines < ActiveRecord::Migration[6.0]
  def change
    create_table :headlines do |t|
      t.text :story
      t.string :importance
      t.date :story_date
      t.date :expiration_date
      t.belongs_to :golfer
      t.belongs_to :season_tournament
      t.belongs_to :society
      t.timestamps
    end
  end
end
