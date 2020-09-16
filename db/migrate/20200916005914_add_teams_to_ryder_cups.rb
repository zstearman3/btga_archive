class AddTeamsToRyderCups < ActiveRecord::Migration[6.0]
  def change
    add_column :ryder_cups, :team_europe_id, :integer
    add_column :ryder_cups, :team_usa_id, :integer
    add_column :ryder_cups, :champion, :integer
    add_index :ryder_cups, :team_europe_id
    add_index :ryder_cups, :team_usa_id
    add_index :ryder_cups, :champion
  end
end
