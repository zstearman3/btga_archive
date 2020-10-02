class AddEventTypeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :season_tournaments, :event_level, :string
    add_column :event_winners, :event_level, :string
  end
end
