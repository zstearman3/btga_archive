class AddIndexToRecordName < ActiveRecord::Migration[6.0]
  def change
    add_index :records, :name
  end
end
