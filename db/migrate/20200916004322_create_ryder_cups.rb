class CreateRyderCups < ActiveRecord::Migration[6.0]
  def change
    create_table :ryder_cups do |t|
      t.belongs_to :season
      t.timestamps
    end
  end
end
