class CreateGolfers < ActiveRecord::Migration[6.0]
  def change
    create_table :golfers do |t|
      
      t.string :name
      t.string :gamertag
      t.decimal :handicap
      t.integer :victories
      t.references :society, foreign_key: true
      t.timestamps
    end
  end
end
