class AddToParFlagToRecord < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :to_par, :boolean
  end
end
