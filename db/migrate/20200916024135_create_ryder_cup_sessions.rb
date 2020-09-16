class CreateRyderCupSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :ryder_cup_sessions do |t|
      t.belongs_to :ryder_cup
      t.string :scoring_type
      t.decimal :team_europe_score
      t.decimal :team_usa_score
      t.integer :order
      t.timestamps
    end
  end
end
