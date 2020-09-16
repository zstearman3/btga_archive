class CreateRyderCupAppearances < ActiveRecord::Migration[6.0]
  def change
    create_table :ryder_cup_appearances do |t|
      t.belongs_to :golfer
      t.belongs_to :ryder_cup_team
      t.boolean :captain, defalut: false
      t.timestamps
    end
  end
end
