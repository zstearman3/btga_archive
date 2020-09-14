class CreateEventWinners < ActiveRecord::Migration[6.0]
  def change
    create_table :event_winners do |t|
      t.belongs_to :golfer
      t.belongs_to :season_tournament
      t.timestamps
    end
  end
end
