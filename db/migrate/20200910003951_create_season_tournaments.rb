class CreateSeasonTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :season_tournaments do |t|
      t.integer :season_order
      t.integer :rounds
      t.date :start_date
      t.date :end_date
      t.belongs_to :course
      t.belongs_to :society
      t.belongs_to :tournament
      t.belongs_to :season
      t.timestamps
    end
  end
end
