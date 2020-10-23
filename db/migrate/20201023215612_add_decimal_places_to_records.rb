class AddDecimalPlacesToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :decimal_places, :integer
  end
end
