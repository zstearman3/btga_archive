class CreateRyderCupTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :ryder_cup_teams do |t|
      t.string :name
      t.timestamps
    end
  end
end
