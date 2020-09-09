class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name, index: {unique: true}
      t.belongs_to :society
      t.belongs_to :course
      t.timestamps
    end
  end
end
