class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string     :name
      t.decimal    :value, precision: 7, scale: 2
      t.date       :date
      t.belongs_to :golfer
      t.belongs_to :golfer_event
      t.belongs_to :season_tournament
      t.belongs_to :society
      t.timestamps
    end
  end
end
